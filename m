From: sricharan@codeaurora.org (Sricharan)
Date: Tue, 21 Jul 2015 12:24:38 +0530
Subject: [PATCH V4 2/7] qup: i2c: factor out common code for reuse
In-Reply-To: <1437380700.6267.1.camel@mm-sol.com>
References: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>	
 <1436412350-19519-3-git-send-email-sricharan@codeaurora.org>
 <1437380700.6267.1.camel@mm-sol.com>
Message-ID: <000001d0c382$2061ceb0$61256c10$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivan,
  Thnaks for all the reviews.

> -----Original Message-----
> From: linux-arm-msm-owner at vger.kernel.org [mailto:linux-arm-msm-
> owner at vger.kernel.org] On Behalf Of Ivan T. Ivanov
> Sent: Monday, July 20, 2015 1:55 PM
> To: Sricharan R
> Cc: devicetree at vger.kernel.org; linux-arm-msm at vger.kernel.org;
> galak at codeaurora.org; linux-kernel at vger.kernel.org; linux-
> i2c at vger.kernel.org; agross at codeaurora.org; dmaengine at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V4 2/7] qup: i2c: factor out common code for reuse
> 
> 
> Hi Sricharan,
> 
> On Thu, 2015-07-09 at 08:55 +0530, Sricharan R wrote:
> >
> 
> >  static int qup_i2c_read_one(struct qup_i2c_dev *qup, struct i2c_msg
> > *msg)  {
> > -       unsigned long left;
> > -       int ret;
> > +       int ret = 0;
> >
> > -       qup->msg = msg;
> > -       qup->pos  = 0;
> > +       /*
> > +               * The QUP block will issue a NACK and STOP on the bus when
> reaching
> > +               * the end of the read, the length of the read is specified as one
> byte
> > +               * which limits the possible read to 256 (QUP_READ_LIMIT) bytes.
> > +               */
> > +       if (msg->len > QUP_READ_LIMIT) {
> > +               dev_err(qup->dev, "HW not capable of reads over %d bytes\n",
> > +                       QUP_READ_LIMIT);
> > +               return -EINVAL;
> > +       }
> >
> 
> This should be removed. Please see qup_i2c_quirks.
> 
  Ok get it, will remove this.

Regards,
 Sricharan
