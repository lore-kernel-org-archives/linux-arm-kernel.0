From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Dec 2011 22:39:52 +0000
Subject: [PATCH 1/2] [media] V4L: atmel-isi: add code to
 enable/disableISI_MCK clock
In-Reply-To: <4C79549CB6F772498162A641D92D5328039E9C15@penmb01.corp.atmel.com>
References: <1322647604-30662-1-git-send-email-josh.wu@atmel.com>
 <20111207084958.GA14542@n2100.arm.linux.org.uk>
 <4C79549CB6F772498162A641D92D5328039E9C15@penmb01.corp.atmel.com>
Message-ID: <20111207223952.GH14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 06:12:52PM +0800, Wu, Josh wrote:
> Hi, Russell King
> 
> On Wed, Dec 07, 2011 at 4:50 PM, Russell King wrote:
> 
> > On Wed, Nov 30, 2011 at 06:06:43PM +0800, Josh Wu wrote:
> >> +	/* Get ISI_MCK, provided by programmable clock or external clock
> */
> >> +	isi->mck = clk_get(dev, "isi_mck");
> >> +	if (IS_ERR_OR_NULL(isi->mck)) {
> 
> > This should be IS_ERR()
> 
> So it means the clk_get() will never return NULL even when clk structure
> is NULL in clk lookup entry. Right?

It is not the drivers business to know whether NULL is valid or not.

clk_get() is defined to either return an error pointer, or a cookie
which the rest of the clk API must accept.

If an implementation decides that clk_get() can return NULL and deals
with that in the rest of the API (eg, to mean 'there is no clock but
don't fail for this') then drivers must not reject that.

If a driver rejects NULL then it is performing checks outside of the
definition of the clk API, and making assumptions about the nature of
valid cookies.
