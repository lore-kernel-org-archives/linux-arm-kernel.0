From: oss@buserror.net (Scott Wood)
Date: Thu, 16 Mar 2017 15:39:23 -0500
Subject: [RFC 4/7] soc/qman: add helper functions needed by caam/qi driver
In-Reply-To: <1488552733-20806-5-git-send-email-horia.geanta@nxp.com>
References: <1488552733-20806-1-git-send-email-horia.geanta@nxp.com>
 <1488552733-20806-5-git-send-email-horia.geanta@nxp.com>
Message-ID: <1489696763.2944.42.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-03 at 16:52 +0200, Horia Geant? wrote:
> Add helper functions, macros, #defines for accessing / enabling
> qman functionality from caam/qi driver, such that this driver
> is not aware of the need for data conversion to big endian.

Why? ?I complained about that (probably internally) when this driver was
originally submitted.

Having a bunch of accessors in a header file that just do an assignment with
an endian conversion just obfuscates things. ?The driver still needs to know
that the conversion needs to happen, or else it wouldn't know that the fields
can't be accessed directly... and it gets particularly ridiculous when a
single field has a growing pile of accessors depending on exactly what flags
you want to set (e.g. qm_sg_entry_set_*). ?Just open-code it unless an
accessor is justified by the call sites getting unwieldy or numerous.

It looks like GCC 6 has added an attribute (scalar_storage_order) that could
be used on structs to avoid having to manually swap such things. ?I look
forward to the day when GCC 6 is old enough for the kernel to depend on this.

-Scott
