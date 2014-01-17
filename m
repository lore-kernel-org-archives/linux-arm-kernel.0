From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 16 Jan 2014 16:33:14 -0800
Subject: [PATCH v2 2/2] i2c: New bus driver for the QUP I2C controller
In-Reply-To: <20140117001833.GL30911@sonymobile.com>
References: <1389659437-16406-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1389659437-16406-3-git-send-email-bjorn.andersson@sonymobile.com>
 <20140115164604.GI14405@codeaurora.org>
 <20140117001833.GL30911@sonymobile.com>
Message-ID: <20140117003314.GB13785@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16, Bjorn Andersson wrote:
> On Wed 15 Jan 08:46 PST 2014, Stephen Boyd wrote:
> 
> > On 01/13, Bjorn Andersson wrote:
> > > +
> > > +static int
> > > +qup_i2c_poll_state(struct qup_i2c_dev *qup, u32 req_state, bool only_valid)
> > > +{
> > > +	int retries = 0;
> > > +	u32 state;
> > > +
> > > +	do {
> > > +		state = readl(qup->base + QUP_STATE);
> > > +
> > > +		/*
> > > +		 * If only valid bit needs to be checked, requested state is
> > > +		 * 'don't care'
> > > +		 */
> > 
> > It looks like req_state == 0 means only_valid == true. Can we
> > drop the only_valid argument to this function?
> > 
> 
> In all cases but the reset in the beginning of qup_i2c_xfer, so it seems that
> it has to stay.

Oh that's because QUP_RESET_STATE is equal to 0? It looks like
bits 0 and 1 are the state field and bit 2 is a flag indicating
that bits 0 and 1 are valid. Why not OR in the QUP_STATE_VALID
flag into the macros that are passed to this function? Then the
logic would simply be looping looking for a match of the
req_state (which is really a mask now).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
