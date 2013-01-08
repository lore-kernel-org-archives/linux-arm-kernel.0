From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Jan 2013 11:49:27 -0700
Subject: [PATCH v3 0/9] Migrate Tegra to common clock framework
In-Reply-To: <50EC1CD3.3070308@nvidia.com>
References: <1357292453-28418-1-git-send-email-pgaikwad@nvidia.com>
 <50E70FE5.9010001@wwwdotorg.org> <50EB6403.5090300@wwwdotorg.org>
 <50EC1CD3.3070308@nvidia.com>
Message-ID: <50EC6A37.4000206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2013 06:19 AM, Prashant Gaikwad wrote:
> On Tuesday 08 January 2013 05:40 AM, Stephen Warren wrote:
>> On 01/04/2013 10:22 AM, Stephen Warren wrote:
>>> On 01/04/2013 02:40 AM, Prashant Gaikwad wrote:
>>>> This patchset does following:
>>>> 1. Decompose single tegra clock structure into multiple clocks.
>>>> 2. Try to use standard clock types supported by common clock framework.
>>>> 3. Use dynamic initialization.
>>>> 4. Move all clock code to drivers/clk/tegra from mach-tegra.
>>>> 5. Add device tree support for Tegra20 and Tegra30 clocks.
>>>> 6. Remove all legacy clock code from mach-tegra.
>>> I think there are bugs here. I applied all your clock patches on top of
>>> Tegra's for-next (see list below), and found that the following don't
>>> work on Springbank:
>>>
>>> * HDMI display
>>> * Audio playback
>>> * WiFi
>> (BTW, I stopped Cc'ing linux-kernel@, but added linux-tegra@ instead...)
>>
>> Prashant, some updated testing results based off the "dev/ccf" branch
>> you sent me on our internal git server:
...
> I have updated the internal branch with all the above mentioned fixes.

WiFi and SPI now work on both Tegra20/30.

PCIe still doesn't work on Tegra20. The reason is that
clk_plle_enable()'s call to _get_table_rate() fails, since
pll->fixed_rate is 0, and hence there's no matching table entry.

I simply commented out that call, and the later code that uses its
results to configure the PLL rate, and then everything worked - or at
least PCIe device enumeration and hence lspci worked, which is as much
as works right now with PCIe on Tegra...

Is the solution here to fix clk-tegra20.c's call to tegra_clk_plle() to
specify a valid fixed rate?

However, I'm puzzled why clk_plle_enable() is even touching the dividers
though; shouldn't clk_plle_set_rate() be setting up the rate, and
clk_plle_enable() /just/ be enabling/disabling the PLL? The old clock
driver appears to work the way I expect, and use the standard PLL
set_rate op for this clock, and has a very simple custom enable op for PLLe.

The remaining item is the display issue on Tegra30, which I'll go look
at now.
