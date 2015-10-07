From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2015 17:23:42 +0100
Subject: [PATCH v2 1/3] nvmem: core: make default user binary file
 root-access only
In-Reply-To: <56152250.2000200@linaro.org>
References: <1444215536-10783-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1444215647-10836-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20151007113349.GJ21513@n2100.arm.linux.org.uk>
 <56152250.2000200@linaro.org>
Message-ID: <20151007162342.GK21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 02:46:56PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 07/10/15 12:33, Russell King - ARM Linux wrote:
> >On Wed, Oct 07, 2015 at 12:00:47PM +0100, Srinivas Kandagatla wrote:
> >>As required by many providers like at24/at25/mxs-ocotp/qfprom and may be
> >>other providers would want to allow root-only to read the nvmem content.
> >>So making the defaults to be root-only access would address the request
> >>and also provide flexibility to providers to specify there own permissions
> >>on top of the root-only using the perm flag in nvmem_config.
> >>Making this dynamic did cut down lot of static binary attributes in the
> >>code.
> >
> >Check what the lifetime of a struct bin_attribute is before you embed it
> >into any other structure.  Sorry, but I think you're going to have to
> 
> Lifetime of the "static struct bin_attribute bin_attr_template" is static
> and a memcpy of which is made into nvmem->bin whose lifetime is till the
> nvmem_release() which happens at device_release(), so there should be no
> issue in using a copy of bin_attribute.

You're assuming that code doesn't touch the attribute after releasing
the last refcount on the device... unless you've actually checked
that, the code is unsafe.

I'm not saying it does or it doesn't (I don't know) but unless you
actually have checked, you haven't done sufficient homework prior to
sending this patch.

Just remember for next time you want to do something similar to this.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
