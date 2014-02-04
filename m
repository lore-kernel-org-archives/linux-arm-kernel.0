From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Tue, 04 Feb 2014 12:05:06 -0500
Subject: UBI leb_write_unlock NULL pointer Oops (continuation) on ARM926
In-Reply-To: <878utq51b4.fsf@nbsps.com> (Bill Pringlemeir's message of "Tue,
 04 Feb 2014 10:45:35 -0500")
References: <D7B1B5F4F3F27A4CB073BF422331203F2A18997F1F@Exchange1.lawo.de>
 <CAFLxGvya5WXoKcYmOgeM_SmVVEht1jEzeLG9vHhwFudFU+Ny8A@mail.gmail.com>
 <D7B1B5F4F3F27A4CB073BF422331203F2A18997F8B@Exchange1.lawo.de>
 <52EF772D.8080207@nod.at>
 <D7B1B5F4F3F27A4CB073BF422331203F2A18DD7989@Exchange1.lawo.de>
 <52EF9FFE.4020405@nod.at>
 <1391498545.1795.29.camel@sauron.fi.intel.com>
 <52F09AC9.6090604@nod.at>
 <1391500492.1795.36.camel@sauron.fi.intel.com>
 <878utq51b4.fsf@nbsps.com>
Message-ID: <874n4e4xml.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On  4 Feb 2014, bpringlemeir at nbsps.com wrote:

> The ARM926 systems do not have proper 'lock free' idioms like
> 'ldrex/strex' and they try to do atomic operations by locking
> interrupts.  I think that UbiFs/UBI maybe called on a 'data fault' or
> 'program fault' (in user space) when memory pressure is present.  I have
> seen this occur in some sound drivers where the data source is coming
> from disk (or maybe the driver uses vmalloc() or something).  So I think
> on occasion, the ltree_lookup() may not work or there is something weird
> with the atomic primatives and data/page faults.


 https://www.google.ca/#q=site:infradead.org+leb_write_unlock+oops

 http://lists.infradead.org/pipermail/linux-mtd/2013-May/046907.html

 at91sam9g20 - arm926, different MTD driver. Linux 3.6.9

 Code: e5903004 e58d2004 e1560003 0a00002a (e593200c)

   0:   e5903004        ldr     r3, [r0, #4]
   4:   e58d2004        str     r2, [sp, #4]
   8:   e1560003        cmp     r6, r3
   c:   0a00002a        beq     0xbc
  10:   e593200c        ldr     r2, [r3, #12]

The code sequence looks identical and the Oops trace, etc is the same.
People from Pengutronix also indicated seeing the same type of Opps; I
think they deal with the IMX, but maybe this was on another board.

Regards,
Bill Pringlemeir.
