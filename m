From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 30 Sep 2014 13:03:30 -0700
Subject: [PATCH] i2c: qup: Fix order of runtime pm initialization
In-Reply-To: <20140930195923.GB26928@qualcomm.com>
References: <1412028051-21774-1-git-send-email-agross@codeaurora.org>
 <20140930015323.GE28481@sonymobile.com>
 <20140930195923.GB26928@qualcomm.com>
Message-ID: <20140930200329.GV28481@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 30 Sep 12:59 PDT 2014, Andy Gross wrote:

> On Mon, Sep 29, 2014 at 06:53:24PM -0700, Bjorn Andersson wrote:
> > On Mon 29 Sep 15:00 PDT 2014, Andy Gross wrote:
> > 
> > > The runtime pm calls need to be done before populating the children via the
> > > i2c_add_adapter call.  If this is not done, a child can run into issues trying
> > > to do i2c read/writes due to the pm_runtime_sync failing.
> > > 
> > 
> > May I ask in what case this would fail?  I thought we tested this as we found
> > the faulty error check after calling pm_runtime_get_sync().
> 
> This is a different kind of failure.   If during probe, the children do some I2C
> activity, they will encounter issues with the runtime_sync due to the pm_runtime
> not being initialized.  However, once the qup probe completes, everything works
> fine.
> 
> The original runtime_sync issue revolved around the runtime_sync return value
> being misinterpreted due to the incorrect check.
> 

Yeah, I just wondered why my testing didn't trigger this. But I suspect that
the answer is simply that the client I ran with did not do i2c accesses from
probe.

Regards,
Bjorn
