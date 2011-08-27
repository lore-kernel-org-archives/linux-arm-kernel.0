From: ming.lei@canonical.com (Ming Lei)
Date: Sun, 28 Aug 2011 01:20:27 +0800
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <CACVXFVNz_ic_PPM_vNn1Dz85A2z94kRFso4rcqrvJfuLSqRSCg@mail.gmail.com>
References: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>
	<20110827151317.GA10013@kroah.com>
	<CACVXFVM_p_XPyOOgz7kbEo93SCCxPa4X_vjYGm+fUGMPSFM4EA@mail.gmail.com>
	<20110827160746.GA11076@kroah.com>
	<CACVXFVNz_ic_PPM_vNn1Dz85A2z94kRFso4rcqrvJfuLSqRSCg@mail.gmail.com>
Message-ID: <CACVXFVNrck4u3d7EaRwuwSVO9J-_0jDQ07U0PCw55FZUxsCszA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Aug 28, 2011 at 12:57 AM, Ming Lei <ming.lei@canonical.com> wrote:

>> Are you sure? ?Have you read the documentation about memory barriers to
>> confirm this?
>
> I read the doc again, :-), and it mentions few about mb/wmb/rmb, I think
> my above description is still not correct. Generally speaking, mb only
> means there is a order between two accesses.
>
> Now I think only one mb() after 'dummy->hw_token = token;' is enough:
> HC will read the up-to-date value of qtd->hw_token after mb() is executed
> because of the effect of the mb(), which should be guaranteed by mb.

Looks like there is still another similar problem in qh_link_async():
the last wmb
should be changed into mb, because HC will read 'head->hw->hw_next' from qh
descriptor and this pointer in qh is read only for HC. But this problem can't be
observed on ARM, since wmb on ARM is same with mb.

thanks,
--
Ming Lei
