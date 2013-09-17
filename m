From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Sep 2013 23:34:07 +0200
Subject: [PATCH v2] ARM: fix Thumb-2 bug in AES assembler code
In-Reply-To: <alpine.LFD.2.03.1309171429580.20709@syhkavp.arg>
References: <1379438195-6911-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.LFD.2.03.1309171429580.20709@syhkavp.arg>
Message-ID: <CAKv+Gu8pgc6tu=8B9qFQe1ndm89_OyAeGHCu=L4F2Gm9xAsYyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 September 2013 20:34, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 17 Sep 2013, Ard Biesheuvel wrote:
>
>> Patch 638591c enabled building the AES assembler code in Thumb2 mode.
>> However, this code used arithmetic involving PC rather than adr{l}
>> instructions to generate PC-relative references to the lookup tables,
>> and this break in Thumb mode due to the different PC offset.
>>
>> Use adr instructions instead.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> v2:
>> - use 'adr' instruction rather than explicit PC arithmetic
>> - move the tables around so they are in range for 'adr' in each mode
>>
>>  arch/arm/crypto/aes-armv4.S | 388 ++++++++++++++++++++++----------------------
>>  1 file changed, 193 insertions(+), 195 deletions(-)
>
> No no no.  NAK.
>
> This makes the patch completely unreviewable.  And unacceptable for
> inclusion into the stable tree.
>
> Also, why do you have to move tables around?
>

Well, my approach was to remove all the PC related arithmetic, but
loading the address of the table itself using adr doesn't work in ARM
as it's too far away, and adrl doesn't exist in Thumb.

> Isn't the following sufficient to fix the issue?
>

Yes, this is obviously much less obtrusive, so much better.
Should I respin my patch or should we just paste your diff into the
patch system?
(I will test it properly first, of course)

Regards,
Ard.


> diff --git a/arch/arm/crypto/aes-armv4.S b/arch/arm/crypto/aes-armv4.S
> index 19d6cd6f29..3a14ea8fe9 100644
> --- a/arch/arm/crypto/aes-armv4.S
> +++ b/arch/arm/crypto/aes-armv4.S
> @@ -148,7 +148,7 @@ AES_Te:
>  @               const AES_KEY *key) {
>  .align 5
>  ENTRY(AES_encrypt)
> -       sub     r3,pc,#8                @ AES_encrypt
> +       adr     r3,AES_encrypt
>         stmdb   sp!,{r1,r4-r12,lr}
>         mov     r12,r0          @ inp
>         mov     r11,r2
> @@ -381,7 +381,7 @@ _armv4_AES_encrypt:
>  .align 5
>  ENTRY(private_AES_set_encrypt_key)
>  _armv4_AES_set_encrypt_key:
> -       sub     r3,pc,#8                @ AES_set_encrypt_key
> +       adr     r3,_armv4_AES_set_encrypt_key
>         teq     r0,#0
>         moveq   r0,#-1
>         beq     .Labrt
> @@ -843,7 +843,7 @@ AES_Td:
>  @               const AES_KEY *key) {
>  .align 5
>  ENTRY(AES_decrypt)
> -       sub     r3,pc,#8                @ AES_decrypt
> +       adr     r3,AES_decrypt
>         stmdb   sp!,{r1,r4-r12,lr}
>         mov     r12,r0          @ inp
>         mov     r11,r2
