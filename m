From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 27 May 2011 15:27:18 -0400 (EDT)
Subject: [RFC PATCH v3] ARM hibernation/suspend-to-disk support
In-Reply-To: <alpine.DEB.2.00.1105271549220.6109@localhost6.localdomain6>
References: <alpine.DEB.2.00.1105251251330.4319@localhost6.localdomain6>
	<alpine.DEB.2.00.1105271549220.6109@localhost6.localdomain6>
Message-ID: <alpine.LFD.2.00.1105271501220.3207@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 May 2011, Frank Hofmann wrote:

>  /*
>   * r0 = control register value
>   * r1 = v:p offset (preserved by cpu_do_resume)
> + *      if this is zero, do not reenable MMU (it's on)

This is wrong.  It is well possible for this to be zero when the MMU is 
active.

The best way to determine if MMU is on or off is:

	mrc	p15, 0, rx, c1, c0	@ load ctrl reg
	tst	rx, #1			@ test M bit

> I wonder; is there a proper/suggested way to switch MMU off (and not end in
> binary nirvana), to have the reentry / reenable work ?

This is slightly complicated.  You first need to turn of and disable the 
caches, and ideally set up a 1:1 mapping for the transition.  There are 
cpu_proc_fin() and cpu_reset(branch_location).

You may also investigate how kexec is handled which purpose is to let 
the kernel boot another kernel.


Nicolas
