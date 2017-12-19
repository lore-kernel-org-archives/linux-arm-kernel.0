From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 19 Dec 2017 13:27:33 -0600
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new ACPI
 HID QCOM8002
In-Reply-To: <20171219023935.GA17456@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
 <1513189818-7384-4-git-send-email-timur@codeaurora.org>
 <20171213230155.GS7997@codeaurora.org>
 <6ca3b4a6-90b9-0481-beb8-29a95c86f07c@codeaurora.org>
 <615426d4-7c46-9671-87ef-790fb5733385@codeaurora.org>
 <20171219023935.GA17456@codeaurora.org>
Message-ID: <1f6b198f-d277-51dd-09ad-e1d751d5c1fa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2017 08:39 PM, Stephen Boyd wrote:
> +	for (i = 0, j = 0; i < num_gpios; i++) {
>   		pins[i].number = i;
> -		pins[i].name = names[i];
> +		groups[i].pins = &pins[i].number;
> +
> +		/* Only expose GPIOs that are available */
> +		if (gpios && gpios[j] != i)
> +			continue;

I don't know if I would say this is an improvement.  For one thing, 
QCOM8001 systems are deprecated and don't really exist any more.  At the 
time I originally wrote this patch, they were still in the wild, but 
they're all gone now.  So it's no longer efficient to treat QCOM8001 as 
the default case.  This means that the for-loop will iterate over the 
full range now, instead of the partial range that it does with my v10 patch.

If I post another version of this patch, I'm just going to remove 
support for QCOM8001.

If you want to avoid kmalloc'ing the GPIOs array, we can put it on the 
stack with a dynamic size, since it will be no more than MAX_GPIOS * 2 
(i.e. 512) bytes in size.

	u16 gpios[avail_gpios];

It would be a little hackish since it needs to be defined at the 
beginning of a code block, so I would probably put into its own 
function, but I still fail to see what's wrong with using kmalloc to 
allocate that array for short-term use temporarily.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
