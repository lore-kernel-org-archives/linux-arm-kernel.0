From: ebiggers3@gmail.com (Eric Biggers)
Date: Wed, 1 Feb 2017 23:38:24 -0800
Subject: [RFC PATCH v2 4/4] crypto: aes - add generic time invariant AES
 for CTR/CCM/GCM
In-Reply-To: <1485646413-17491-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1485646413-17491-1-git-send-email-ard.biesheuvel@linaro.org>
 <1485646413-17491-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170202073824.GC582@zzz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Sat, Jan 28, 2017 at 11:33:33PM +0000, Ard Biesheuvel wrote:
> 
> Note that this only implements AES encryption, which is all we need
> for CTR and CBC-MAC. AES decryption can easily be implemented in a
> similar way, but is significantly more costly.

Is the expectation of decryption being more costly the only reason why "aes-ti"
couldn't be a "cipher" algorithm, allowing it to automatically be used by the
existing templates for CTR, CBC-MAC, CBC, ECB, XTS, CMAC, etc.?  It doesn't seem
to do anything expensive on a per-block basis like loading SSE registers, so it
seems it would fit better as a "cipher" algorithm if at all possible.  Then
there would be no need to implement all these modes yet again.

Also, what would be the feasibility of simply replacing aes-generic with the
time-invariant implementation, rather than offering two implementations and
requiring users to choose one, usually without the needed expertise?

> +
> +/*
> + * Emit the sbox as __weak with external linkage to prevent the compiler
> + * from doing constant folding on sbox references involving fixed indexes.
> + */
> +__weak const u8 __cacheline_aligned __aesti_sbox[] = {

Did you consider marking it 'volatile' instead?

> +static int aesti_set_key(struct aes_ti_ctx *ctx, const u8 *in_key,
> +			 unsigned int key_len)
> +{
> +	struct crypto_aes_ctx rk;
> +	int err;
> +
> +	err = crypto_aes_expand_key(&rk, in_key, key_len);
> +	if (err)
> +		return err;

crypto_aes_expand_key() assumes that the key is u32-aligned; I don't think
that's guaranteed here.

Eric
