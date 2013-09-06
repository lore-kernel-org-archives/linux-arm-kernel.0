From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 06 Sep 2013 13:09:22 -0600
Subject: [PATCH] ARM: tegra: throw the unique chip ID into the entropy pool
In-Reply-To: <CACRpkdYVUC+MM2SC446k=HC=FwsJMtD6YQa9Hcu8C9eMKMdYng@mail.gmail.com>
References: <1378394938-1551-1-git-send-email-linus.walleij@linaro.org>
 <5228DECA.4090601@wwwdotorg.org>
 <CACRpkdYVUC+MM2SC446k=HC=FwsJMtD6YQa9Hcu8C9eMKMdYng@mail.gmail.com>
Message-ID: <522A2862.9060607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2013 02:53 AM, Linus Walleij wrote:
> On Thu, Sep 5, 2013 at 9:43 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
...
>> Note that the UID value appears to be incorrect on anything other than
>> Tegra20; I'll file an internal bug to track that down.
> 
> Hm, that will not affect the kernel entropy pool so much, but
> the crypto driver is in trouble since that seems to be the only
> entropy it's using :-(

Well, it calls getnstimeofday() too, so there's presumably a small
amount of entropy there, unless tegra_aes_rng_reset() gets called at
predictable times, which is probably true.

> If it will return something like a constant, that is actually a quite
> valid case for initializing tmp[1] from the kernel entropy pool
> with get_random_bytes() instead of using UID.
> 
> I don't know if the Tegra AES needs that specific initializer
> though (it seems not). Shall I propose a patch?

That sounds reasonable. Perhaps Varun can comment?
