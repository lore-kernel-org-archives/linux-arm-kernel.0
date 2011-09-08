From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2011 12:29:01 +0200
Subject: [PATCH 16/18] dmaengine/amba-pl08x: Add support for sg len
	greater than one for slave transfers
In-Reply-To: <4E683B74.5000701@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<5d691ab0c4f447c9f324213d8d740ac61d1739a1.1311936524.git.viresh.kumar@st.com>
	<20110814083618.GE4986@n2100.arm.linux.org.uk>
	<4E4CCF7B.8060704@st.com>
	<20110821083306.GA12028@n2100.arm.linux.org.uk>
	<4E532B19.6000103@st.com> <4E5715CE.2070806@st.com>
	<CACRpkdapSvW=eMSoXTOOA2GyhfBLzq2OuyQcDctPxsnVzvr-4g@mail.gmail.com>
	<4E575E75.40603@st.com> <4E5F594D.10203@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A4C@bgsmsx502.gar.corp.intel.com>
	<CAKnu2Mp3Ui7jZS2kjJykjuzcTzJhiAkoaVxZ2+tQX0banGh6mw@mail.gmail.com>
	<4E683B74.5000701@st.com>
Message-ID: <CACRpkdaqTYK5TJL2u+aeOfnzhdtdjxZhyu661eGKrNBOXTUTeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 5:50 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> If i am getting this clearly, the concern is "why to queue separate transfers for
> individual sg's? Better would be to prepare the complete list at once and
> start the transfer, so that DMA stops only after finishing all sg's
> passed from user." Is this what you are pointing at?

Yes.

> If yes, then the same is done in this patch too. An array for llis is allocated at
> the start, then for each sg i prepare lli list from this array. Last lli from one sg
> is followed by first lli from next sg. And so i get a continuous chain of llis.

OK so I guess I was lost in the code ...

So this is mainy cached as txd->dsg_list so you can quickly retrieve the
number of bytes pending in the LLI by traversing that sglist.

This is better than what the coh901318 does, because that driver
resorts to going into the physical LLIs themselves to retrieve this
info.

It also seems like this will play nice with Per Forlin's MMC
speed-up patches, so that will become effective for your MMC
usecases.

Now I really like this patch.

Sorry for being such a slow learner!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
