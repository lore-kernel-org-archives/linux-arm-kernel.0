From: s-anna@ti.com (Suman Anna)
Date: Wed, 25 Jun 2014 11:32:13 -0500
Subject: [PATCH 6/6] mailbox/omap: add a custom of_xlate function
In-Reply-To: <5721425.bMLltMQDlc@wuerfel>
References: <1403660878-56350-1-git-send-email-s-anna@ti.com>
 <1403660878-56350-7-git-send-email-s-anna@ti.com>
 <5721425.bMLltMQDlc@wuerfel>
Message-ID: <53AAF98D.7070309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 06/25/2014 03:39 AM, Arnd Bergmann wrote:
> On Tuesday 24 June 2014 20:47:58 Suman Anna wrote:
>> +static struct mbox_chan *omap_mbox_of_xlate(struct mbox_controller *controller,
>> +                                           const struct of_phandle_args *sp)
>> +{
>> +       phandle phandle = sp->args[0];
>> +       struct device_node *node;
>> +       struct omap_mbox_device *mdev;
>> +       struct omap_mbox *mbox;
>> +
>> +       node = of_find_node_by_phandle(phandle);
>> +       if (!node) {
>> +               pr_err("could not find node phandle 0x%x\n", phandle);
>> +               return NULL;
>> +       }
>> +
>> +       mdev = container_of(controller, struct omap_mbox_device, controller);
>> +       if (WARN_ON(!mdev))
>> +               return NULL;
>> +
>> +       mbox = omap_mbox_device_find(mdev, node->name);
>> +       return mbox ? mbox->chan : NULL;
>>
> 
> Wouldn't it be easier to change the omap_mbox_device_find() function to
> take a phandle argument directly? You shouldn't have to walk all
> nodes in the system, or match it by name if you already have the 
> device node.

The omap_mbox_device_find() function is also used on the non-DT mailbox
client path (for OMAP3) at the moment where we don't have the device
node pointers. I am merely reusing the function for the DT lookup path,
and once I remove the non-DT support, I can surely do the matching logic
just based on the device node pointer. I just chose to minimize the
changes to the omap_mbox_device_find() to do both variants now when I
know that I am gonna remove the non-DT part (name lookup) later on.

The current expected DT usage model for the OMAP mailbox client is (with
the v7 mailbox framework)
    mbox = <&controller_phandle &channel_phandle>

So, this is not walking through all the nodes in the system, only the
channel/sub-mailbox nodes present on the particular controller node.
Surely, it can done as mbox = <&channel_phandle> as the parent
controller node relationship is inherent, but this requires changes to
the mailbox framework, and I am not sure if every platform
implementation would implement the child channels as their own nodes.

> 
> Also, the xlate function is normally the place where you read out
> the other arguments and set them as members in your omap_mbox
> structure.

The current flow for the xlate function is during the
mailbox_request_channel. The channels themselves would have been
registered during the controller node probe, so this is merely a lookup
for the correct channel. Should we be renaming the xlate function, if
the behavior is not what one expects out of a standard xlate?

regards
Suman
