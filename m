From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 25 May 2011 16:25:23 +0530
Subject: [PATCH] dmaengine: Add API documentation for slave dma usage
In-Reply-To: <BANLkTinbSAxozR6NivY6wddre1nRF5RmZA@mail.gmail.com>
References: <1306238657-30089-1-git-send-email-vinod.koul@intel.com>
	<BANLkTikDPeEFWdsVQ=Ak8jXEXsC-+uoOaw@mail.gmail.com>
	<1306253171.30236.9.camel@vkoul-udesk3>
	<BANLkTikjxECNAK5eS5hSu2bbEKpZX341Dw@mail.gmail.com>
	<BANLkTikAm=D_YNFt0Regeas6AX8116L0-A@mail.gmail.com>
	<1306312009.30236.110.camel@vkoul-udesk3>
	<BANLkTikn3BBeNyuUeZ9BhG5QLj-dmcGjTg@mail.gmail.com>
	<1306316082.30236.137.camel@vkoul-udesk3>
	<BANLkTinbSAxozR6NivY6wddre1nRF5RmZA@mail.gmail.com>
Message-ID: <1306320923.30236.158.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-25 at 16:21 +0530, Per Forlin wrote:
> On 25 May 2011 11:34, Koul, Vinod <vinod.koul@intel.com> wrote:

> I would like to ask a question on usage of DMA_CTRL_ACK while we're at it.
> In ste_dma40 I added support to reuse descriptors if DMA_CTRL_ACK is
> clear. The purpose of DMA_CTRL_ACK is to set up dependency but is it
> also a valid to reuse it?
> I mean submit the same descriptor again and again without having to
> call prepare_slave_sg.
> Example:
> desc = prepare_slave_sg()
> submit(desc)
> issue_pending(desc)
> 
> wait_for_callback()
> 
> submit(desc)
> issue_pending(desc)
> 
I think your question is answered in dmaengine.h. Quoting here:
* @DMA_CTRL_ACK - if clear, the descriptor cannot be reused until the 
* client acknowledges receipt, i.e. has has a chance to establish any
* dependency chains

The DMA driver recycles the descriptors which it returns for the
transfer APIs. The DMA_CTRL_ACK flag would tell driver explicitly not to
reuse this descriptor until the client clears this flag.
Since the descriptor is still valid after callback notification it can
be reused by client in the way you described.

Again, Dan can you please confirm if my interpretation is correct.


-- 
~Vinod
