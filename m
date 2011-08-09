From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Aug 2011 20:51:14 +0100
Subject: How to handle named resources with DT?
In-Reply-To: <4E40FC88.5090403@ti.com>
References: <4E40FC88.5090403@ti.com>
Message-ID: <20110809195114.GB14281@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 11:23:20AM +0200, Cousson, Benoit wrote:
> Hi Grant,
>
> Trying to bind hwmod informations with DT, I'm facing a little limitation.
> A bunch of drivers are using the platform_get_resource_byname, so the  
> name for the resource is needed.
>
> The name is used so far for IORESOURCE_MEM, IORESOURCE_IRQ and  
> IORESOURCE_DMA types of resources.
>
> Do you have any plan to add that, or do you have any clean way to avoid  
> that without having to use the resource index?

Named resources are evil.  You only have to look at /proc/iomem to see
why that's the case.  Here's an example:

b7a01000-b7a01003 : set
  b7a01000-b7a01003 : set
b7a01004-b7a01007 : dat
  b7a01004-b7a01007 : dat
b7a01008-b7a0100b : dirout
  b7a01008-b7a0100b : dirout
b7a01020-b7a01023 : set
  b7a01020-b7a01023 : set
b7a01024-b7a01027 : dat
  b7a01024-b7a01027 : dat
b7a01028-b7a0102b : dirout
  b7a01028-b7a0102b : dirout
b7a01040-b7a01043 : set
  b7a01040-b7a01043 : set
b7a01044-b7a01047 : dat
  b7a01044-b7a01047 : dat
b7a01048-b7a0104b : dirout
  b7a01048-b7a0104b : dirout
b7a01060-b7a01063 : set
  b7a01060-b7a01063 : set
b7a01064-b7a01067 : dat
  b7a01064-b7a01067 : dat
b7a01068-b7a0106b : dirout
  b7a01068-b7a0106b : dirout
b7a01080-b7a01083 : set
  b7a01080-b7a01083 : set
b7a01084-b7a01087 : dat
  b7a01084-b7a01087 : dat
b7a01088-b7a0108b : dirout
  b7a01088-b7a0108b : dirout

How very informative.  Not.  So what device owns those?  Who knows,
that's lost by the crappy named resource stuff.
