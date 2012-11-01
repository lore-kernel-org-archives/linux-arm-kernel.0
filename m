From: Russ.Dill@ti.com (Russ Dill)
Date: Wed, 31 Oct 2012 17:55:29 -0700
Subject: [RFC 1/7] capebus: Core capebus support
In-Reply-To: <EBB972CD-D9D9-4704-AABF-2DFCED584297@antoniou-consulting.com>
References: <1351702333-8456-1-git-send-email-panto@antoniou-consulting.com>
 <1351702333-8456-2-git-send-email-panto@antoniou-consulting.com>
 <CA+Bv8XZ5WnhsKqYA6TBv8wh6OvOdU-G8XhuV2dO49O1qX_FRgg@mail.gmail.com>
 <EBB972CD-D9D9-4704-AABF-2DFCED584297@antoniou-consulting.com>
Message-ID: <CA+Bv8XZ2bMNvb77R5gqz7FVaCF1RtfTbiaCDE6iAKk3UUmnj6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 3:07 PM, Pantelis Antoniou
<panto@antoniou-consulting.com> wrote:
>
> On Oct 31, 2012, at 11:55 PM, Russ Dill wrote:
>
>> On Wed, Oct 31, 2012 at 9:52 AM, Pantelis Antoniou
>> <panto@antoniou-consulting.com> wrote:
>>> Introducing capebus; a bus that allows small boards (capes) to connect
>>> to a complex SoC using simple expansion connectors.
>>>
>
> [snip]
>>> +       if (drv) {
>>> +               /* call the removed bus method (if added prev.) */
>>> +               if (cape_dev->added) {
>>> +                       BUG_ON(cape_dev->bus == NULL);
>>> +                       BUG_ON(cape_dev->bus->ops == NULL);
>>> +                       if (cape_dev->bus->ops->dev_removed)
>>> +                               cape_dev->bus->ops->dev_removed(cape_dev);
>>> +                       cape_dev->added = 0;
>>> +               }
>>
>> Is there any case where added will not track drv?
>
>
> Yes, there is a corner case here.
>
> There is the case where while the device is created there is no matching
> driver yet. Either that's the case of a not supported cape, or the
> cape driver hasn't been loaded yet.
>
> We do need the device to be created, so that the user can browse in the
> sysfs it's eeprom attributes.
>
> There's some further complications with runtime cape overrides, but
> that's the gist of it.

I'm trying to figure out how that would come about, here is where
added is set to 1:

+       /* all is fine... */
+       cape_dev->driver = drv;
+       cape_dev->added = 1;

This is after calling drv->probe, so drv is not null.

There is a brief time here where added is 0, but driver is not.

+       if (drv) {
+               /* call the removed bus method (if added prev.) */
+               if (cape_dev->added) {
+                       BUG_ON(cape_dev->bus == NULL);
+                       BUG_ON(cape_dev->bus->ops == NULL);
+                       if (cape_dev->bus->ops->dev_removed)
+                               cape_dev->bus->ops->dev_removed(cape_dev);
+                       cape_dev->added = 0;
+               }
+               if (drv->remove) {
+                       pm_runtime_get_sync(dev);
+                       drv->remove(cape_dev);
+                       pm_runtime_put_noidle(dev);
+               }
+               cape_dev->driver = NULL;

Is one of the remove or resume functions check added in this case?
