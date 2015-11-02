From: slash.tmp@free.fr (Mason)
Date: Mon, 2 Nov 2015 11:10:40 +0100
Subject: CPU_METHOD_OF_DECLARE() with Linux as non-secure OS
In-Reply-To: <yw1xpozvavui.fsf@unicorn.mansr.com>
References: <5630C143.5080103@free.fr> <yw1xio5pd5mf.fsf@unicorn.mansr.com>
 <56325C67.8000007@free.fr> <yw1xeggdd007.fsf@unicorn.mansr.com>
 <5633CF2A.4040504@free.fr> <yw1xpozvavui.fsf@unicorn.mansr.com>
Message-ID: <563736A0.9040804@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/10/2015 16:41, M?ns Rullg?rd wrote:

> Mason writes:
> 
>> On 29/10/2015 19:04, M?ns Rullg?rd wrote:
>>
>>> There's also something wrong with the L2C-310 aux control register
>>> setting.  The SMC call ID from OMAP (0x109) which is also used in some
>>> Sigma code I found somewhere doesn't seem to do anything, so the
>>> register is left at the value set by the secure boot code.  Perhaps you
>>> can check with your firmware guy if there's another way of writing that
>>> register.
>>
>> IIRC, only debug firmware allows writes to L2 AUXCTRL (after filtering
>> some of the bits out), while production firmware ignores them completely.
>>
>> IME, the smc handler should default to return ENOTSUP; that way, when
>> a syscall disappears due to ifdef-ery, the caller gets a meaningful
>> answer.
>>
>> We just had an interesting internal discussion about L2 AUXCTRL.
>> For my education, what value would you like to write to AUXCTRL? :-)
> 
> The best value to use depends on the workload, so it would be nice to be
> able to control all the purely performance related bits.  I see no
> possible benefit in restricting the non-secure kernel from writing
> these.

For the record, the latest firmware uses 0x72860401.

[ 0] Full Line of Zero enable
[10] High Priority for SO and Dev Reads enable
[11] Store buffer device limitation disable
[12] Exclusive cache configuration disable
[13] Shared Attribute Invalidate disable
[16] Associativity 8-way
[17-19] Way-size = 64
[20] Event monitor bus disable
[21] Parity disable
[22] Shared attribute override disable
[23:24] Force write allocate = 0x1
[25] Cache replacement policy = 1
[26] Non-secure lock-down disable
[27] Non-secure interrupt access control disable
[28] Data prefetch enable
[29] Instruction prefetch enable
[30] Early BRESP enable

Everyone, feel free to comment on these choices ;-)

Regards.
