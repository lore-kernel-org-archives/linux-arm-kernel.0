From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 25 Feb 2014 08:12:36 +0100
Subject: [RFC PATCH] arm64: add support for AES in CCM mode using Crypto
 Extensions
In-Reply-To: <20140225070252.GB9934@gondor.apana.org.au>
References: <1392106905-28709-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140225070252.GB9934@gondor.apana.org.au>
Message-ID: <CAKv+Gu-HnTk5RCLRoCnae7-HH7C-Tq2YJF57Nc-hOEykdY52XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 February 2014 08:02, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Feb 11, 2014 at 09:21:45AM +0100, Ard Biesheuvel wrote:
>> This adds support for a synchronous implementation of AES in CCM mode
>> using ARMv8 Crypto Extensions, using NEON registers q0 - q5.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>> Hi all,
>>
>> I am posting this for review/RFC. The main topic for feedback is the way
>> I have used an inner blkcipher instance to process the encrypted + authenticated
>> data.
>>
>> The point of having a dedicated module for synchronous ccm(aes) is the fact that
>> mac80211 uses it for WPA2 CCMP en-/decryption, where it runs entirely in soft
>> IRQ context. In this case, the performance improvement offered by dedicated AES
>> instructions is likely wasted on stacking and unstacking the NEON register file,
>> as the generic CCM operates on a single AES block at a time.
>>
>> Instead, this implementation interleaves the CTR and CBC modes at the round
>> level, eliminating 50% of both the input and round key loads and (hopefully)
>> eliminating pipeline stalls by operating on two AES blocks at a time.
>>
>> Tested with tcrypt, no performance numbers yet.
>
> I think your idea definitely make sense, since we do the same
> thing in aesni-intel.
>
> It'll be interesting to see some numbers, especially if we could
> compare this against the generic version that we talked about
> earlier.
>

Hi Herbert,

Thanks for taking a look.

I will definitely come back with performance numbers as soon as I
manage to produce any.
Do you have any comments specifically about using an inner blkcipher
instance to implement the aead?

Thanks,
Ard.
