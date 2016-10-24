From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 24 Oct 2016 14:27:36 -0700
Subject: [PATCH v1 0/3] Add support for Broadcom OTP controller
In-Reply-To: <CA+55aFwAZPJ+o0qkYjJziHofYvvsocHuWr1YUmVnzj6VTv_sgA@mail.gmail.com>
References: <1477336324-10543-1-git-send-email-jonathan.richardson@broadcom.com>
 <CAADWXX-43-k2K2T1V5MQMd0z0V502wf1syNHERPfvNstOJw-3A@mail.gmail.com>
 <e34f01b6-a059-9988-0f93-e5adb82a5436@gmail.com>
 <CA+55aFwAZPJ+o0qkYjJziHofYvvsocHuWr1YUmVnzj6VTv_sgA@mail.gmail.com>
Message-ID: <82ad10b1-32ab-3962-d5ab-e787e2c70130@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 01:14 PM, Linus Torvalds wrote:
> On Mon, Oct 24, 2016 at 12:54 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> The older setup was using smtphost.broadcom.com which we have now
>> documented as being invalid, here Jonathan used gmail directly (since
>> that's our mail provider now):
>>
>> Received: from lbrmn-lnxub108.corp.ad.broadcom.com ([216.31.219.19])
>>         by smtp.gmail.com with ESMTPSA id
>> s89sm8325746qkl.44.2016.10.24.12.12.00
>>         (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
>>         Mon, 24 Oct 2016 12:12:03 -0700 (PDT)
> 
> Hmm. I get that too, so if that's the right thing for a broadcom.com
> address, it's not the smtp server issue.
> 
> We had a few cases of the kernel mailing list itself messing up emails
> sufficiently to fail dkim, but that shouldn't be an issue for the
> relaxed/relaxed model that broadcom uses (the vger mailing list
> software screws up whitespace, which "relaxed" ignores).
> 
>> Is there something else we need to check? Here is what I read for the
>> cover-letter:
>>
>> Authentication-Results: mx.google.com;
>>        dkim=pass header.i=@broadcom.com;
>>        spf=pass (google.com: domain of ...
> 
> Hmm. I get:
> 
>   Authentication-Results: mx.google.com;
>          dkim=fail header.i=@broadcom.com;
> 
> with the actual dkim signature looking like this:
> 
>   DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>         d=broadcom.com; s=google;
>         h=from:to:cc:subject:date:message-id;
>         bh=9zStGnsZQDQqP6cm1CHPk7EYVtLvDsm2wN5qy5Mgx7M=;
>         b=Z/1QD+FwJogJY9D8Qd197Q+VJt7Tr9+WoHFeKYRL00yhvxrMg0P8jKj1FbucJTluvM
>          agC2eq9qCpZcNAfridjExDRDCuUPAIJIXTr9Npkpqlk6gEMq2FysrGer2D9Z4HQ/atTX
>          67VirFsQK0gK7impYMn9kW5Q9BIIw5bOg7OdI=
> 
> and those fields that it protects look like this:
> 
>   From: Jonathan Richardson <jonathan.richardson@broadcom.com>
>   To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime
> Ripard <maxime.ripard@free-electrons.com>
>   Cc: linux-arm-kernel at lists.infradead.org,
> linux-kernel at vger.kernel.org, devicetree at vger.kernel.org, Mark Rutland
> <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Scott
> Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
> bcm-kernel-feedback-list at broadcom.com, Jonathan Richardson
> <jonathan.richardson@broadcom.com>
>   Subject: [PATCH v1 0/3] Add support for Broadcom OTP controller
>   Date: Mon, 24 Oct 2016 12:12:01 -0700
>   Message-Id: <1477336324-10543-1-git-send-email-jonathan.richardson@broadcom.com>
> 
> and I don't see anything obviously wrong anywhere - except for that
> "dkim=fail" thing, and the email being in my spam folder.

Should we compare the headers added by lists.infradead.org and see what
could possibly go wrong here? I can see that by being delivered to
lists.infradead.org and then back to my personal gmail.com (not my other
broadcom.com account), there are a bunch of extra headers:

X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3
X-CRM114-CacheID: sfid-20161024_121226_013940_81319C20
X-CRM114-Status: GOOD (  13.05  )
X-Spam-Score: -2.7 (--)
X-Spam-Report: SpamAssassin version 3.4.0 on bombadil.infradead.org summary:
 Content analysis details:   (-2.7 points)
 pts rule name              description
 ---- ----------------------
--------------------------------------------------
 -0.7 RCVD_IN_DNSWL_LOW      RBL: Sender listed at
http://www.dnswl.org/, low
 trust [2607:f8b0:400d:c09:0:0:0:22f listed in] [list.dnswl.org]
 -0.0 SPF_PASS               SPF: sender matches SPF record
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
 [score: 0.0000]
 -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
 -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
 domain
 0.1 DKIM_SIGNED            Message has a DKIM or DK signature,
 not necessarily valid
X-BeenThere: linux-arm-kernel at lists.infradead.org
X-Mailman-Version: 2.1.20
Precedence: list

Would those be used by your mail client to put this mail in spam, or was
that done by the linux-foundation.org (also gmail?) mail upon reception?
-- 
Florian
