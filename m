From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Sep 2013 09:07:05 +0100
Subject: kmalloc memory slower than malloc
In-Reply-To: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
References: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
Message-ID: <20130906080705.GN6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 06, 2013 at 09:48:02AM +0200, Thommy Jakobsson wrote:
> Hi,
> 
> doing a project where I use DMA and a DMA-capable buffer in a driver. This 
> buffer is then mmap:ed to userspace, the driver notice userspace 
> that the device has filled the buffer. Pretty standard setup I think.

Your driver appears to be exposing physical addresses to userspace.
This is a no-go.  This is a massive security hole - it allows userspace
to map any physical address and write into that memory.  That includes
system flash and all system RAM.

This gives userspace a way to overwrite the kernel with exploits,
retrieve sensitive and/or personal data, etc.

Therefore, I will not provide any assistance with this.  Please change
your approach so you do not need physical addresses in userspace.

I know that some closed source libraries, particularly GPU and video
decode libraries like to take this approach.  Everyone should be aware
that such approaches bypass all system security, especially if the GPU
or video device is accessible to any userspace process.

In your case, your device driver special device node just has to be
accessible to any userspace process.
