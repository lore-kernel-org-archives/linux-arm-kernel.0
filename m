From: david@lechnology.com (David Lechner)
Date: Tue, 2 Jan 2018 11:10:50 -0600
Subject: =?UTF-8?Q?Re:_[PATCH_v4_0/7]_ARM:_davinci:_convert_to_common_clock_?=
 =?UTF-8?B?ZnJhbWV3b3Jr4oCL?=
In-Reply-To: <CAHCN7x+50anim4-F++Fd78tuPo9+OdKgvOZ-+jWc=0QFcng5CA@mail.gmail.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
 <CAHCN7x+50anim4-F++Fd78tuPo9+OdKgvOZ-+jWc=0QFcng5CA@mail.gmail.com>
Message-ID: <d268b81e-2231-8224-50e8-c11b3fed97f2@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2018 09:10 AM, Adam Ford wrote:
> On Sun, Dec 31, 2017 at 5:39 PM, David Lechner <david@lechnology.com> wrote:
>> This series converts mach-davinci to use the common clock framework.
>>
>> Basically, this series does some cleanup and rearranging to get things
>> ready for the conversion. Then there is a patch to add new driver in
>> drivers/clk and finally a patch to make the conversion from the mach
>> clock drivers to the new drivers.
>>
>> I have tested this on LEGO MINDSTORMS EV3 (TI AM1808), so I am confident
>> that I haven't broken anything (too badly) in da850. But, I don't have
>> other hardware to test.
> 
> I tested this on a DA850-EVM, but I was not able to successfully get it to boot.
> 
> It hangs during boot with no errors, oops's, or panics, but the
> standard 4.15.0-rc5 from linux-stable booted just fine.
> 
> Maybe one of the TI guys will have some suggestions, but as-is, it
> appears to break at least the DA850-evm.
> 

Thanks for testing. Unfortunately, the only hardware I have is the LEGO
MINDSTORMS, so I will have to rely on others to help with the debugging.
If you or anyone else with one of these boards can make the time, please
compile with:

CONFIG_DEBUG_LL=y
CONFIG_EARLY_PRINTK=y

and add "earlyprintk" to the kernel command line options. You may need to
select a different UART for this depending on your board. I think UART1 is
the default in the kernel configuration.

On da850 devices comment out the line:

	clk_set_parent(clk, pll1_sysclk2_clk);

in da850.c when doing earlyprintk, otherwise the UART1 and UART2 clock source
will change during boot and cause garbled output after a point.

>>
>> The one thing that I know I have broken is CPU frequency scaling on da850.
>> I don't think it was working with device tree anyway, so I can't really test
>> it with the hardware I have. I'm hoping that it will be OK to defer fixing
>> it and add device tree support at the same time.
>>
> 
> I agree with you that it's broken in the device tree, but I don't
> think it ever worked.
> 
>> Dependencies:
>> * This series applies on top of "ARM: davinici: move watchdog restart from
>>    mach to drivers" [1][2]
>> * On da850, you will also need a patch to prevent problems with the USB PHY
>>    clocks [3]
>> * Or get it all at once:
>>      git fetch https://github.com/dlech/ev3dev-kernel.git common-clk-v4
> 
> That is what I pulled to test.
> 
> adam
> 
