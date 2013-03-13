From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Mar 2013 22:42:30 -0600
Subject: [RFC 1/1] clk: Add notifier support in
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1363139273.21694.11.camel@bilhuang-vm1>
References: <1363091861-21534-1-git-send-email-bilhuang@nvidia.com>
 <20130312134032.GU4977@n2100.arm.linux.org.uk>
 <1363139273.21694.11.camel@bilhuang-vm1>
Message-ID: <514003B6.8020904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2013 07:47 PM, Bill Huang wrote:
> On Tue, 2013-03-12 at 21:40 +0800, Russell King - ARM Linux wrote:
>> On Tue, Mar 12, 2013 at 05:37:41AM -0700, Bill Huang wrote:
>>> Add the below four notifier events so drivers which are interested in
>>> knowing the clock status can act accordingly. This is extremely useful
>>> in some of the DVFS (Dynamic Voltage Frequency Scaling) design.
>>>
>>> PRE_CLK_ENABLE
>>> POST_CLK_ENABLE
>>> PRE_CLK_DISABLE
>>> POST_CLK_DISABLE
>>>
>>> Signed-off-by: Bill Huang <bilhuang@nvidia.com>
>>
>> NAK.  *Sigh* NO, this is the wrong level to be doing stuff like this.
>>
>> The *ONLY* thing that clk_prepare_enable() and clk_prepare_disable() should
>> *EVER* be doing is calling clk_prepare(), clk_enable(), clk_disable() and
>> clk_unprepare().  Those two functions are *merely* helpers for drivers
>> who don't wish to make the individual calls.
>>
>> Drivers are still completely free to call the individual functions, at
>> which point your proposal breaks horribly - and they _do_ call the
>> individual functions.
>
> I'm proposing to give device driver a choice when it knows that some
> driver might be interested in knowing its clock's enabled/disabled state
> change at runtime, this is very important for centralized DVFS core
> driver. It is not meant to be covering all cases especially for drivers
> which is not part of the DVFS, so we don't care if it is calling
> clk_enable/disable directly or not.

I believe the point Russell is making is not that the idea behind this
patch is wrong, but simply that the function where you put the hooks is
wrong. The hooks should at least be in clk_enable/clk_disable and not
clk_prepare_enable/clk_disable_unprepare, since any driver is free to
call clk_prepare separately from clk_enable. The hooks should be
implemented in the lowest-level common function that all
driver-accessible paths call through.
