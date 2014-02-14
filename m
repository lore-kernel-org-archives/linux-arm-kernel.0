From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Feb 2014 13:47:56 +0000
Subject: [PATCH 0/6] ARM: integrator: multiplatform advancements
In-Reply-To: <1392373771-17303-1-git-send-email-linus.walleij@linaro.org>
References: <1392373771-17303-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140214134756.GI30257@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 11:29:25AM +0100, Linus Walleij wrote:
> The *real* solution, one might argue is to convert the CLCD
> driver to DRM and add device tree bindings, but it appears that
> this is an orthogonal goal that has been attempted by other with
> mixed results.

What mixed results?  You know, I find it rather sick that people run
around trying to do this to a driver that I authored and maintain
without one comment to me about it.  It sometimes feels like people
think I don't exist anymore.

The biggest complaint I've heard against DRM is the amount of code
required.  That's partly because we haven't - until now - had a good
way to separate the "connectors" as stand-alone implementations separate
from the core DRM drivers.  I'm hopeful that by 3.15, we will see some
implementations (imx-drm and armada) start making use of this.

Also, remember that DRM is Direct Rendering Manager, which incorporates
Kernel Mode Setting.  It's the KMS part which is most relevant to things
like CLCD since it has no GPU.  However, the non-KMS bits also are when
you have something like a Mali GPU or other GPU.

We /really/ need these GPUs to move over to DRM - any ARM platform using
a GPU today is inherently insecure since they all have been coded to push
physical addresses around everywhere, which basically means userspace can
use the GPU to access parts of the system such as overwriting bits of the
kernel.

It's useless write-protecting the vectors page and/or the kernel text in
a vain attempt to provide additional security if the GPU can be used from
userspace to write to that RAM.

Having everything under DRM eliminates that problem because userspace only
gets to deal with handles to the various buffers rather than physical
addresses, which ensures that you can't specify an address for a buffer
you don't own.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
