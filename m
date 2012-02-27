From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Mon, 27 Feb 2012 16:27:23 +0000
Subject: [PATCH-WIP 01/13] xen/arm: use r12 to pass the hypercall number
 to the hypervisor
In-Reply-To: <1330019314-20865-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
 <1330019314-20865-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1330360043.8557.302.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-02-23 at 17:48 +0000, Stefano Stabellini wrote:
> We need a register to pass the hypercall number because we might not
> know it at compile time and HVC only takes an immediate argument.
> 
> Among the available registers r12 seems to be the best choice because it
> is defined as "intra-procedure call scratch register".

R12 is not accessible from the 16 bit "T1" Thumb encoding of mov
immediate (which can only target r0..r7).

Since we support only ARMv7+ there are "T2" and "T3" encodings available
which do allow direct mov of an immediate into R12, but are 32 bit Thumb
instructions.

Should we use r7 instead to maximise instruction density for Thumb code?

Ian.
