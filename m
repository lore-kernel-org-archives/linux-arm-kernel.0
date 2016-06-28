From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 28 Jun 2016 20:51:29 +0530
Subject: [PATCH 2/3] mailbox: Add Broadcom PDC mailbox driver
In-Reply-To: <CAG4BRp=CbdTWM3NipEZoFmBy=gEzpPiN=1jtK4oEVv+9Bg67Kg@mail.gmail.com>
References: <1464113250-15629-1-git-send-email-rob.rice@broadcom.com>
 <1464113250-15629-3-git-send-email-rob.rice@broadcom.com>
 <CABb+yY3igUUnvzMBtqjhvCfS82HLUHK_PGZBrQOENOPY6nu56A@mail.gmail.com>
 <CAG4BRp=CbdTWM3NipEZoFmBy=gEzpPiN=1jtK4oEVv+9Bg67Kg@mail.gmail.com>
Message-ID: <CABb+yY1s_m-80yetUd381NpWVaDDMzLp5v=h8kaKHbpH5nGHng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 7:06 PM, Rob Rice <rob.rice@broadcom.com> wrote:

>>>  drivers/mailbox/Kconfig                 |    9 +
>>>  drivers/mailbox/Makefile                |    2 +
>>>  drivers/mailbox/mailbox-pdc/Makefile    |    8 +
>>>  drivers/mailbox/mailbox-pdc/pdc.c       | 1181 +++++++++++++++++++++++++++++++
>>>  drivers/mailbox/mailbox-pdc/pdc.h       |  303 ++++++++
>>>  drivers/mailbox/mailbox-pdc/pdc_debug.c |  101 +++
>>>  drivers/mailbox/mailbox-pdc/pdc_debug.h |   24 +
>>>
>> We already have mailbox api testing rig - mailbox-test, still if you
>> really need debugfs exposure please merge it in pdc.c especially when
>> pdc_debug.c is only 80lines and it always compiled and currently has
>> to export functions globally. Maybe fold everything in a single like
>> other platforms?
>
> [WRR] I'm using debugfs to display stats, not so much for testing the
> module. So I don't think mailbox-test is a substitute. But if you
> prefer, I'll move the stats code into pdc.c, along with the code from
> pdc.h and move pdc.c from the mailbox-pdc directory up to
> drivers/mailbox.
>
Yes, please merge them.

>>> +/**
>>> + * pdc_hw_init() - Use the given initialization parameters to initialize the
>>> + * state for one of the PDCs.
>>> + * @dev:   device structure for PDC
>>> + * @pdcs:  state of the PDC
>>> + * @parms: parameter values to set
>>> + */
>>> +static
>>> +void pdc_hw_init(struct device *dev, struct pdc_state *pdcs,
>>> +                struct hw_init_parms *parms)
>>>
>> You could do without the dev and parms.
>
> [WRR] Yes, I can get dev from pdcs. but parms is a stack variable in
> the calling function and has to be passed, as I see it.
>
hw_init_parms is invented only to be passed to pdc_hw_init from probe.
.ring_entries is PDC_RING_ENTRIES
.hw_pbase is unused
.hw_vbase is pdcs->pdc_reg_vbase

thanks.
