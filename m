From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 23 Feb 2017 15:25:59 -0800
Subject: [RFC/PATCH] of: Mark property::value as const
In-Reply-To: <58AF6B88.6020709@gmail.com>
References: <20170214025040.23955-1-stephen.boyd@linaro.org>
 <58AF6B88.6020709@gmail.com>
Message-ID: <58AF6F87.4040005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/17 15:08, Frank Rowand wrote:
> On 02/13/17 18:50, Stephen Boyd wrote:
>> The 'blob' we pass into populate_properties() is marked as const,
>> but we cast that const away when we assign the result of
>> fdt_getprop_by_offset() to pp->value. Let's mark value as const
>> instead, so that code can't mistakenly write to the value of the
>> property that we've so far advertised as const.
> 
> Instead of struct property field value being a pointer into the
> FDT, I would rather copy the data to newly allocated memory and
> have value be a pointer to that memory.  This is required if we
> want to make /sys/firmware/fdt optional, which would allow us to
> free the memory containing the initial boot FDT.
> 
> I also do not want overlay live subtrees to have any pointers
> into the FDT that was used to populate the overlay, so copying
> the data solves that problem also.
> 
> 
>> Unfortunately, this exposes a problem with the fdt resolver code,
>> where we overwrite the value member of properties of phandles to
>> update them with their final value. Add a comment for now to
>> indicate where we're potentially writing over const data.
> 
> Yes, the resolver code needs to adjust phandle values.
> 
> I think I can get rid of the resolver modifying the various phandle
> values, and instead just modify the phandle value in struct
> device_node.  At the same time, I think I can also remove all
> instances of the phandle properties ('linux,phandle', 'ibm,phandle',
> 'phandle') in the live tree.  These properties should not be
> accessed directly by any code outside of the device tree framework
> since the phandle is located in the struct device_node.  A quick
> grep does not show any such accesses of the phandle properties,
> but I want to look more closely.

If I remove the various phandle properties from the live tree,
the one place I can not inspect for impact is the live tree that
is exposed at /proc/device-tree/  I do not know whether that is
a problem or not.

-Frank
