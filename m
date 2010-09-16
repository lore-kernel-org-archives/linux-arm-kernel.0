From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 16 Sep 2010 21:53:39 +0200
Subject: [PATCH v6 2/7] wl1271: propagate set_power's return value
In-Reply-To: <1284666018.8951.66.camel@powerslave>
References: <1284592929-29616-1-git-send-email-ohad@wizery.com>
	<1284592929-29616-3-git-send-email-ohad@wizery.com>
	<1284666018.8951.66.camel@powerslave>
Message-ID: <AANLkTimp2JT4XT5EHwKwmMQ+5KYgHTOzpqDwF3UjGDBh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 9:40 PM, Luciano Coelho
<luciano.coelho@nokia.com> wrote:
>> + ? ? int ret = wl->if_ops->power(wl, true);
>
> I think it look nicer if you keep the "int ret" in one line by itself
> and then do a ret = wl->if_ops... on another one.

Fixed.

>> +static int wl1271_sdio_power_on(struct wl1271 *wl)
>> ?{
>> ? ? ? struct sdio_func *func = wl_to_func(wl);
>>
>> ? ? ? sdio_claim_host(func);
>> ? ? ? sdio_enable_func(func);
>> ? ? ? sdio_release_host(func);
>> +
>> + ? ? return 0;
>> ?}
>
> You seem to always return 0, so the whole chain to pass the value up
> seems unnecessary. ?Is this just a preparation for a future patch?

Yes, it's soon going to be:

static int wl1271_sdio_power_on(struct wl1271 *wl)
{
 ? ? ? struct sdio_func *func = wl_to_func(wl);
       int ret;

       ret = pm_runtime_get_sync(&func->dev);
       if (ret)
                 goto out;

 ? ? ? sdio_claim_host(func);
 ? ? ? sdio_enable_func(func);
 ? ? ? sdio_release_host(func);

out:
   ? ? return ret;
}


Thanks,
Ohad.

>
> --
> Cheers,
> Luca.
>
>
