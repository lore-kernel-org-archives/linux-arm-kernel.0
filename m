From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 19 Aug 2016 22:41:24 +0200
Subject: [PATCH v1 2/3] of: Add support for reading a s32 from a
 multi-value property.
In-Reply-To: <1471616119.61594.465.camel@infradead.org>
References: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com>
 <1471315139-28285-3-git-send-email-finley.xiao@rock-chips.com>
 <1471616119.61594.465.camel@infradead.org>
Message-ID: <4975010.IL95Y3Sj1J@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 19. August 2016, 15:15:19 CEST schrieb David Woodhouse:
> On Tue, 2016-08-16 at 10:38 +0800, Finlye Xiao wrote:
> > From: Finley Xiao <finley.xiao@rock-chips.com>
> > 
> > This patch adds an of_property_read_s32_index() function to allow
> > reading a single indexed s32 value from a property containing multiple
> > s32 values.
> > 
> > Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> 
> NAK.
> 
> Nobody should be using the old of_property_* functions any more anyway.
> You should be using the generic device_propery_* functions which work
> regardless of where the information comes from (actual DT vs. ACPI
> _DSD).
>
> So no, don't *add* any more of these functions. Only add the generic
> version. And if your driver isn't using the generic property
> functions... fix it.

As far as I can see, all the device_property_* functions are grounded on their
of_property_*, acpi_property_* etc counterparts and functions reading specific
elements (the _index variants) are currently not available at all.

drivers/base/property.c:
#define OF_DEV_PROP_READ_ARRAY(node, propname, type, val, nval)				\
	(val) ? of_property_read_##type##_array((node), (propname), (val), (nval))	\
	      : of_property_count_elems_of_size((node), (propname), sizeof(type))

So even if you're using the device_property_* functions you'd still need
a match in the underlying functions or am I missing something?
