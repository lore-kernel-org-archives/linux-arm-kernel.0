From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 23 Feb 2017 17:38:24 -0600
Subject: [RFC/PATCH] of: Mark property::value as const
In-Reply-To: <58AF6B88.6020709@gmail.com>
References: <20170214025040.23955-1-stephen.boyd@linaro.org>
 <58AF6B88.6020709@gmail.com>
Message-ID: <CAL_JsqJwMob=XN=SBXict4iz3QrLX01iRbMxhWEzC8zpD4XomA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 5:08 PM, Frank Rowand <frowand.list@gmail.com> wrote:
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

Making a copy would simplify several things.

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

Good idea.

BTW, I recently noticed that dtc by default generates both
linux,phandle and phandle properties. I would think the new one has
been around long enough that we can turn off the old one by default
now.

Rob
