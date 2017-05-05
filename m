From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Fri, 5 May 2017 01:41:06 +0100
Subject: [PATCH] pinctrl: use non-devm kmalloc versions for free functions
In-Reply-To: <20170504160032.GA5147@htj.duckdns.org>
References: <1493855857-4453-1-git-send-email-andre.przywara@arm.com>
 <20170504120314.lfmcv4cpsuz2igte@lukather>
 <20170504160032.GA5147@htj.duckdns.org>
Message-ID: <95a58640-f9e3-edb5-12e5-a6f92e75bdb0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/17 17:00, Tejun Heo wrote:

Hi,

> Hello,
> 
> On Thu, May 04, 2017 at 02:03:14PM +0200, Maxime Ripard wrote:
>>> @@ -704,6 +704,7 @@ static void pinctrl_generic_free_groups(struct pinctrl_dev *pctldev)
>>>  		radix_tree_delete(&pctldev->pin_group_tree, indices[i]);
>>>  		devm_kfree(pctldev->dev, group);
>>>  	}
>>> +	kfree(indices);
>>
>> We use devm_kfree for other allocations done here, maybe we can just
>> have the same thing here? We would be consistant, and we would still
>> keep the resource tracking.
> 
> It doesn't make any sense to use the managed functions from the
> release functions and if you're always matching devm_kmalloc() with
> devm_kfree(), the only thing it'd do is confusing its readers.

I agree, the idea of this patch is to get rid of managed functions. Also
my understanding is that devm_kfree needs to match some devm_kmalloc().

> And the function in question just looks weird to me - give up on
> freeing resources if memory allocation fails?  And why call
> devm_kfree() on objects which are being released anyway?  Or if the
> group can be released w/o the device being detached, why use devm
> allocations on the members at all?
> 
> As for removal, can't it just call radix_tree_iter_delete() while
> iterating?  Why allocate memory to iterate and store all indices and
> to look them up again and delete them?

Yeah, I was wondering about this as well. It looks like it just wants to
clean up everything; the implementation of ida_destroy() seems to have
the same intention and uses radix_tree_iter_delete().

Using this algorithm would avoid the memory allocation in the first
place, so fix the issue as well and simplify the code.

So is there anything we miss here why we store all indices and iterate
twice over the tree?

Cheers,
Andre.
