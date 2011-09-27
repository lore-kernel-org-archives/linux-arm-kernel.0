From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Tue, 27 Sep 2011 15:12:22 +0200
Subject: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
In-Reply-To: <CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
	<1316195506-9777-2-git-send-email-ohad@wizery.com>
	<20110927100505.GH2138@amd.com>
	<CAK=WgbahwY+7Ux-RjW2Tw9WBSwZnYuTMZ2NQASWyOXQ3zF6qFg@mail.gmail.com>
Message-ID: <20110927131222.GL2138@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 08:26:29AM -0400, Ohad Ben-Cohen wrote:
> > With an unsigned long you can use plain and fast bit_ops instead of the
> > full bitmap functions.
> 
> Not sure I follow; the only bit operation I'm using while mapping is
> find_next_bit() (which is a bitops.h method).
> 
> What other faster variant are you referring to ?

You pass a pointer to an unsigned long for the page-size bitmap. This
allows to use an array of unsigned long. But a single unsigned long is
sufficient and you can use functions like ffs() and fls() together with
shifting. These functions often translate to a single intruction in the
binary. The find_next_bit function has much more overhead because it
needs to handle the array-of-ulong case.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
