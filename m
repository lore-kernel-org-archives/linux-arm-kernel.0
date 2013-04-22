From: nerv@dawncrow.de (=?ISO-8859-1?Q?Andr=E9_Hentschel?=)
Date: Mon, 22 Apr 2013 23:07:35 +0200
Subject: [PATCHv2] arm: Preserve TPIDRURW on context switch
In-Reply-To: <20130422151836.GA15665@mudshark.cambridge.arm.com>
References: <517168BB.3070903@dawncrow.de>
 <20130422143616.GP14496@n2100.arm.linux.org.uk>
 <20130422151836.GA15665@mudshark.cambridge.arm.com>
Message-ID: <5175A697.3080308@dawncrow.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.04.2013 17:18, schrieb Will Deacon:
> On Mon, Apr 22, 2013 at 03:36:16PM +0100, Russell King - ARM Linux wrote:
>> On Fri, Apr 19, 2013 at 05:54:35PM +0200, Andr? Hentschel wrote:
>>> From: =?UTF-8?q?Andr=C3=A9=20Hentschel?= <nerv@dawncrow.de>
>>>
>>> There are more and more applications coming to WinRT, Wine could support them,
>>> but mostly they expect to have the thread environment block (TEB) in TPIDRURW.
>>> This register must be preserved per thread instead of being cleared.
>>>
>>> Signed-off-by: Andr? Hentschel <nerv@dawncrow.de>
>>
>> This actually makes things less efficient all round, because you
>> now use the value immediately after loading, which means it will cause
>> pipeline stalls, certainly on older CPUs.
>>
>> Could you please rework the patch to try avoiding soo many modifications
>> to the way things have been done here?
> 
> copy_thread also needs updating so that the *register* value for the parent
> is copied to the child, since the parent may have written the register
> after the last context-switch, meaning that tp_value is out-of-date.

Thank you both for reviewing.

I guess you mostly mean "ldr	r6, [r2, #TI_CPU_DOMAIN]".
I just thought about old CPUs and remembered again that we at Wine
need that patch only on v7 (and later). So is it ok to introduce a set_tls_v7
in tls.h and make use of CONFIG_CPU_V7 compile-time check in
the changed files and in the copy_thread function?
Do i need any further flag checks in copy_thread or can i use the
compile-time check to add unconditional code?
