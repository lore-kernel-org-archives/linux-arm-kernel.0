From: joelf@ti.com (Joel Fernandes)
Date: Thu, 7 Nov 2013 15:39:22 -0600
Subject: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
In-Reply-To: <527BCFD8.9010207@gmail.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com>
 <527BC118.1050609@ti.com> <527BCFD8.9010207@gmail.com>
Message-ID: <527C088A.8080701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2013 11:37 AM, Daniel Mack wrote:
[..]
>> I know ti,edma-regions property is not currently being used, but we should>>
future proof this by setting up DRAE for like done in probe:
>>
>>                 for (i = 0; i < info[j]->n_region; i++) {
>>                         edma_write_array2(j, EDMA_DRAE, i, 0, 0x0);
>>                         edma_write_array2(j, EDMA_DRAE, i, 1, 0x0);
>>                         edma_write_array(j, EDMA_QRAE, i, 0x0);
>>                 }
>
> That doesn't work for me. I'm running long-time tests here on a device
> which has a mwifiex connected to omap_hsmmc. The test procedure includes:
>
> a) a script on the device that puts the device to sleep some seconds
> after it has been woken up
>
> b) a script on a host that wakes up the device with wake-on-lan every 10
> seconds
>
> c) a flood ping that checks whether the device is responding
>
>
> That precedure is running since a couple of hourse here, and it works
> well with both by v3 and v4 patches. Moving the functions to
> .suspend/resume _noirq doesn't seem to break anything.
>
> Setting QRAE to 0 as you mentioned above, however, makes the device fail
> at resume.

Yes, I recall that. It definitely shouldn't be done.

>>> +static SIMPLE_DEV_PM_OPS(edma_pm_ops, edma_pm_suspend, edma_pm_resume);
>>
>> I agree with Nishanth here, it is better to do this in .suspend/resume _noirq
>> stage to rule out any ordering bugs that may show up in the future, since such
>> an issue already showed up in earlier testing.
>
> Alright, I already did that.

Cool, can you post the updated patch? I'll run some more tests too..

>> I would appreciate it if you can make these 2 changes and post a v5. Thanks for
>> a lot for all the hardwork.
>
> No problem at all :)
>
>> Acked-by: Joel Fernandes <joelf@ti.com>
>
> Still sure about that? What about your follow-up to your own reply?
>

Yes, the Ack definitely stands for the changes you made since the last revision.
Only thing left is to fix the ordering, Let's do that (you seem to have already
done it) and test this a bit more.

Glad you're working on this, thanks!

-Joel
