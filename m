From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Sep 2013 10:53:47 +0200
Subject: [PATCH] ARM: tegra: throw the unique chip ID into the entropy pool
In-Reply-To: <5228DECA.4090601@wwwdotorg.org>
References: <1378394938-1551-1-git-send-email-linus.walleij@linaro.org>
 <5228DECA.4090601@wwwdotorg.org>
Message-ID: <CACRpkdYVUC+MM2SC446k=HC=FwsJMtD6YQa9Hcu8C9eMKMdYng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 5, 2013 at 9:43 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 09/05/2013 09:28 AM, Linus Walleij wrote:
>> This adds a hook at common late init to extract the 64 bits of
>> chip-unique data and throw it into the entropy pool to make it
>> more device-unique.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Stephen: since I don't have the Tegra reference manual I don't
>> know what "UID" means, but if it means "unique ID" then this
>> patch should be relevant for initializing the entropy pool.
>
> I believe that's what it means, although even the TRM doesn't actually say.

I sort of half-guessed it from the fact that it was being used
as random seed in the crypto driver in
drivers/crypto/tegra-aes.c

> I'll try and remember to apply this after the merge window.
>
> Note that the UID value appears to be incorrect on anything other than
> Tegra20; I'll file an internal bug to track that down.

Hm, that will not affect the kernel entropy pool so much, but
the crypto driver is in trouble since that seems to be the only
entropy it's using :-(

If it will return something like a constant, that is actually a quite
valid case for initializing tmp[1] from the kernel entropy pool
with get_random_bytes() instead of using UID.

I don't know if the Tegra AES needs that specific initializer
though (it seems not). Shall I propose a patch?

Yours,
Linus Walleij
