From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Apr 2018 14:23:36 +0200
Subject: [PATCH 2/2 v2] drm/pl111: Enable device-specific assigned memory
In-Reply-To: <87fu46o67b.fsf@anholt.net>
References: <20180406141935.6801-1-linus.walleij@linaro.org>
 <20180406141935.6801-2-linus.walleij@linaro.org> <87fu46o67b.fsf@anholt.net>
Message-ID: <CACRpkdaT5SPQrdkHKG1tqvs=nqJ6G+BrUQyg0J-_aevMe1vK8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 8, 2018 at 3:08 AM, Eric Anholt <eric@anholt.net> wrote:

>>       if (of_property_read_u32(dev->of_node, "max-memory-bandwidth",
>>                                &priv->memory_bw)) {
>>               dev_info(dev, "no max memory bandwidth specified, assume unlimited\n");
>> @@ -275,7 +280,8 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
>>       priv->regs = devm_ioremap_resource(dev, &amba_dev->res);
>>       if (IS_ERR(priv->regs)) {
>>               dev_err(dev, "%s failed mmio\n", __func__);
>> -             return PTR_ERR(priv->regs);
>> +             ret = PTR_ERR(priv->regs);
>> +             goto mem_rel;
>>       }
>
> Shouldn't this error path be jumping to dev_unref, as well?  We're
> trying to match drm_dev_alloc(), right?

OK I fixed.

> I'm still a little bothered that we're allowing imports to pl111 of CMA
> buffers that we can't scan out.  Could we just refuse all
> .gem_prime_import*() on this platform?

I am sorry but I do not understand how CMA, dmabuf and GEM play
together to decode this and figure out what to do.

Do you mean that if we find device assigned memory, i.e. that there
is this special memory which is all the controller can scan out,
I should just implement .gem_prime_impport() instead of the
currently assigned drm_gem_prime_import() to something just
returning return ERR_PTR(-EINVAL); so it always fails?

What about .gem_prime_import_sg_table()? Exporting should
work fine since the memory is always readable by CPU.

Yours,
Linus Walleij
