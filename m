From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 14 Jun 2012 13:29:56 -0600
Subject: Follow-up to remaining issue with alignment of __log_buf in
 printk.c
In-Reply-To: <87aa05vgzg.fsf@free.fr>
References: <87aa05vgzg.fsf@free.fr>
Message-ID: <4FDA3BB4.9040607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2012 01:19 PM, Robert Jarzmik wrote:
> 
> Hi Stephen and others,
> 
> I have a XScale PXA based board with has the alignement issue which makes the
> kernel trap during its early stage.
> 
> I wonder what is the status now, is there a fix available ?
> 
> I have tracked what happens on PXA. The pxa is an ARM v5TE chip. The new printk
> version you submitted is translated to the following assembly on the line :
>         msg->ts_nsec = local_clock();
> Into:
> => 0xc001bbe0 <log_store+496>:	strd	r0, [r4, r5]
> 
> In ARMv5, the "strd" assembly opcode expects the address to be 64bits aligned,
> hence the bug.
> 
> Now the solutions I have seen so far in the mailing lists :
>  - #define LOG_ALIGN (__alignof__(u64))
>    Does always work.
>  - #define LOG_ALIGN (__alignof__(struct log))
>    Doesn't work with my toolchain, as __alignof__(struct log) is 4, not 8

Isn't that a bug in the toolchain; isn't the alignment of a struct
required to be the greatest alignment of any of its members? Otherwise,
this problem could arise with any usage of that struct.

I suppose this could be worked around with something like:

#define LOG_ALIGN max(__alignof__(struct log), __alignof__(u64))
