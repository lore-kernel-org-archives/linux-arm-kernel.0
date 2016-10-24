From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 24 Oct 2016 13:14:53 -0700
Subject: [PATCH v1 0/3] Add support for Broadcom OTP controller
In-Reply-To: <e34f01b6-a059-9988-0f93-e5adb82a5436@gmail.com>
References: <1477336324-10543-1-git-send-email-jonathan.richardson@broadcom.com>
 <CAADWXX-43-k2K2T1V5MQMd0z0V502wf1syNHERPfvNstOJw-3A@mail.gmail.com>
 <e34f01b6-a059-9988-0f93-e5adb82a5436@gmail.com>
Message-ID: <CA+55aFwAZPJ+o0qkYjJziHofYvvsocHuWr1YUmVnzj6VTv_sgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 12:54 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> The older setup was using smtphost.broadcom.com which we have now
> documented as being invalid, here Jonathan used gmail directly (since
> that's our mail provider now):
>
> Received: from lbrmn-lnxub108.corp.ad.broadcom.com ([216.31.219.19])
>         by smtp.gmail.com with ESMTPSA id
> s89sm8325746qkl.44.2016.10.24.12.12.00
>         (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
>         Mon, 24 Oct 2016 12:12:03 -0700 (PDT)

Hmm. I get that too, so if that's the right thing for a broadcom.com
address, it's not the smtp server issue.

We had a few cases of the kernel mailing list itself messing up emails
sufficiently to fail dkim, but that shouldn't be an issue for the
relaxed/relaxed model that broadcom uses (the vger mailing list
software screws up whitespace, which "relaxed" ignores).

> Is there something else we need to check? Here is what I read for the
> cover-letter:
>
> Authentication-Results: mx.google.com;
>        dkim=pass header.i=@broadcom.com;
>        spf=pass (google.com: domain of ...

Hmm. I get:

  Authentication-Results: mx.google.com;
         dkim=fail header.i=@broadcom.com;

with the actual dkim signature looking like this:

  DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9zStGnsZQDQqP6cm1CHPk7EYVtLvDsm2wN5qy5Mgx7M=;
        b=Z/1QD+FwJogJY9D8Qd197Q+VJt7Tr9+WoHFeKYRL00yhvxrMg0P8jKj1FbucJTluvM
         agC2eq9qCpZcNAfridjExDRDCuUPAIJIXTr9Npkpqlk6gEMq2FysrGer2D9Z4HQ/atTX
         67VirFsQK0gK7impYMn9kW5Q9BIIw5bOg7OdI=

and those fields that it protects look like this:

  From: Jonathan Richardson <jonathan.richardson@broadcom.com>
  To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime
Ripard <maxime.ripard@free-electrons.com>
  Cc: linux-arm-kernel at lists.infradead.org,
linux-kernel at vger.kernel.org, devicetree at vger.kernel.org, Mark Rutland
<mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Scott
Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
bcm-kernel-feedback-list at broadcom.com, Jonathan Richardson
<jonathan.richardson@broadcom.com>
  Subject: [PATCH v1 0/3] Add support for Broadcom OTP controller
  Date: Mon, 24 Oct 2016 12:12:01 -0700
  Message-Id: <1477336324-10543-1-git-send-email-jonathan.richardson@broadcom.com>

and I don't see anything obviously wrong anywhere - except for that
"dkim=fail" thing, and the email being in my spam folder.

               Linus
