From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 20 Oct 2015 11:50:14 +0200
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <CAL_Jsq+jthx9ffnUm-G-TV9LdxBRp3SKyhyfcVu=7kN3CuumJw@mail.gmail.com>
References: <560EAA7C.3070302@free.fr> <5124277.UR9sg1IOHT@wuerfel>
 <560EFDB3.9010305@free.fr> <11113740.WL812ZaRcZ@wuerfel>
 <5612A473.8030405@sigmadesigns.com> <5613EF4C.30603@sigmadesigns.com>
 <CAL_JsqJ+WTBYF=sJWbkgNzL48H5AiXL4aoVV3DNiL6T_UQKQfg@mail.gmail.com>
 <561D2952.4060908@sigmadesigns.com>
 <CAL_JsqKa4trfpLY_DPsjBrfH-7SSUQMACYVW7DNN1=Pv3B4FrA@mail.gmail.com>
 <5624CF62.6020001@sigmadesigns.com>
 <CAL_Jsq+jthx9ffnUm-G-TV9LdxBRp3SKyhyfcVu=7kN3CuumJw@mail.gmail.com>
Message-ID: <56260E56.10403@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/10/2015 18:39, Rob Herring wrote:

> Marc Gonzalez wrote:
>
>> About the cache controller, I was confused by this comment:
>>         /*
>>          * Always enable non-secure access to the lockdown registers -
>>          * we write to them as part of the L2C enable sequence so they
>>          * need to be accessible.
>>          */
>>         l2x0_saved_regs.aux_ctrl = aux | L310_AUX_CTRL_NS_LOCKDOWN;
>>
>> I see no lock() function, only unlock().
>>
>> But the unlock function merely writes 0 to the relevant registers,
>> and 0 is the value at reset for those registers. Since nothing ever
>> sets the registers to non-zero, why is the unlock needed at all?
> 
> It was because some bootloaders set those registers. Linux just wants
> them to be all unlocked.

I see.

My problem then, is that my current firmware does not set L310_AUX_CTRL_NS_LOCKDOWN
and does not allow updating that bit.

So when l2c_unlock() is called, Linux (running in non-secure mode)
tries to write to read-only registers:

> On reset, the Non-Secure Lockdown Enable bit is set to 0 and Lockdown
> Registers are not permitted to be modified by non-secure accesses. In
> that configuration, if a non-secure access tries to write to those
> registers, the write response returns a DECERR response. This decode 
> error results in the registers not being updated.

I suppose "a DECERR response" means Linux will oops?

I see several options to work-around this problem:

A) Have the firmware set L310_AUX_CTRL_NS_LOCKDOWN at boot

B) Have the firmware allow Linux to set L310_AUX_CTRL_NS_LOCKDOWN

C) Have a way in Linux to define .unlock as a NOP (trusting the
firmware to NOT have locked anything)
Perhaps adding a "no-unlock-required;" boolean property to the l2cc
node, which would override the .unlock method?

I'd like to hear suggestions on the "best" approach.

Regards.
