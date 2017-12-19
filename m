From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Dec 2017 12:30:55 -0800
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new
 ACPI HID QCOM8002
In-Reply-To: <1f6b198f-d277-51dd-09ad-e1d751d5c1fa@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
 <1513189818-7384-4-git-send-email-timur@codeaurora.org>
 <20171213230155.GS7997@codeaurora.org>
 <6ca3b4a6-90b9-0481-beb8-29a95c86f07c@codeaurora.org>
 <615426d4-7c46-9671-87ef-790fb5733385@codeaurora.org>
 <20171219023935.GA17456@codeaurora.org>
 <1f6b198f-d277-51dd-09ad-e1d751d5c1fa@codeaurora.org>
Message-ID: <20171219203055.GF7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19, Timur Tabi wrote:
> On 12/18/2017 08:39 PM, Stephen Boyd wrote:
> >+	for (i = 0, j = 0; i < num_gpios; i++) {
> >  		pins[i].number = i;
> >-		pins[i].name = names[i];
> >+		groups[i].pins = &pins[i].number;
> >+
> >+		/* Only expose GPIOs that are available */
> >+		if (gpios && gpios[j] != i)
> >+			continue;
> 
> I don't know if I would say this is an improvement.  For one thing,
> QCOM8001 systems are deprecated and don't really exist any more.  At
> the time I originally wrote this patch, they were still in the wild,
> but they're all gone now.  So it's no longer efficient to treat
> QCOM8001 as the default case.  This means that the for-loop will
> iterate over the full range now, instead of the partial range that
> it does with my v10 patch.
> 
> If I post another version of this patch, I'm just going to remove
> support for QCOM8001.

That sounds good too. The diff was really noisy because all the
foo[i] became foo[gpio] which causes the diff to increase for no
real purpose. My patch was rewriting that stuff so it doesn't
come into the diff and we can concentrate on what's actually
changing. We already iterate over the full range to fill in the
two fields anyway, so I'm not sure what you're getting at with
your for-loop comment. Seems like a micro-optimization on probe
that probably isn't going to be noticed.

> 
> If you want to avoid kmalloc'ing the GPIOs array, we can put it on
> the stack with a dynamic size, since it will be no more than
> MAX_GPIOS * 2 (i.e. 512) bytes in size.
> 
> 	u16 gpios[avail_gpios];
> 
> It would be a little hackish since it needs to be defined at the
> beginning of a code block, so I would probably put into its own
> function, but I still fail to see what's wrong with using kmalloc to
> allocate that array for short-term use temporarily.
> 

Yeah I wouldn't do that. I'm not trying to avoid allocating the
array anymore. Dynamically sized arrays on the stack are not a
great idea in the kernel where we have limited stack sizes.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
