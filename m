From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 2 Oct 2018 11:16:55 +0200
Subject: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on
 CPU32v3
In-Reply-To: <CAK8P3a3TE8HW0wD9ETCDWMf7quDRx94-2iS6goYDQ18JQ6r=rw@mail.gmail.com>
References: <20180930024904.14240-1-Jason@zx2c4.com>
 <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
 <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com>
 <CAK8P3a3TE8HW0wD9ETCDWMf7quDRx94-2iS6goYDQ18JQ6r=rw@mail.gmail.com>
Message-ID: <CAKv+Gu-BPAH6Xiggji9Vs3o89nGfdhhAeGz=GKCqNSo9mkWd7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(adding Eric since he wrote the ChaCha20 scalar code)

On 2 October 2018 at 09:51, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Oct 2, 2018 at 5:53 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>
>> Hi Arnd,
>>
>> Apologies for the delay in getting back to you. I had some MTA issues
>> and stupidly assumed ARM developers were taking the day off instead...
>>
>> On Tue, Oct 2, 2018 at 5:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> > -arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3
>> > +arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3m
>>
>> Unfortunately this doesn't really cut it in my case, as it's not only
>> those multiplications:
>> chacha20-arm.S:402: Error: selected processor does not support `bxeq
>> lr' in ARM mode
>>
>> I think we're going to wind up playing whack-a-mole in silly ways. The
>> fact of the matter is that the ARM assembly I'm adding to the tree is
>> for ARMv4 and up, and not for ARMv3.
>
> I don't see what issues remain. The 'reteq lr' that Ard mentioned
> is definitely the correct way to return from assembly (you also need
> that for plain armv4, as 'bx' was added in armv4t), and Russell
> confirmed that using -march=armv3m is something we want
> anyway for mach-rpc.
>

In fact, this bxeq instruction is the only remaining impediment to
building all scalar code with -march-arm3m, and looking at the code

ENTRY(chacha20_arm)
    cmp r2, #0 // len == 0?
    bxeq lr

it seems to me that we can move this len == 0 check into the caller instead.

index 163815f51aac..b2108e00d451 100644
--- a/lib/zinc/chacha20/chacha20-arm-glue.h
+++ b/lib/zinc/chacha20/chacha20-arm-glue.h
@@ -59,6 +59,8 @@ static inline bool chacha20_arch(struct chacha20_ctx
*ctx, u8 *dst,
                        src += bytes;
                        simd_relax(simd_context);
                } else {
+                       if (unlikely(!len))
+                               break;
                        chacha20_arm(dst, src, len, ctx->key, ctx->counter);
                        ctx->counter[0] += (len + 63) / 64;
                        break;
diff --git a/lib/zinc/chacha20/chacha20-arm.S b/lib/zinc/chacha20/chacha20-arm.S
index 5abedafcf129..845843a14ab1 100644
--- a/lib/zinc/chacha20/chacha20-arm.S
+++ b/lib/zinc/chacha20/chacha20-arm.S
@@ -398,9 +398,6 @@
  *                  const u32 iv[4]);
  */
 ENTRY(chacha20_arm)
-       cmp             r2, #0                  // len == 0?
-       bxeq            lr
-
        push            {r0-r2,r4-r11,lr}

        // Push state x0-x15 onto stack.
