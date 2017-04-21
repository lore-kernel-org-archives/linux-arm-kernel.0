From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Fri, 21 Apr 2017 12:08:43 -0600
Subject: [PATCH V15 03/11] cper: add timestamp print to CPER status
 printing
In-Reply-To: <20170421172603.4574wonnm5tgvbcn@pd.tnic>
References: <1492556723-9189-1-git-send-email-tbaicar@codeaurora.org>
 <1492556723-9189-4-git-send-email-tbaicar@codeaurora.org>
 <20170421122150.76cce2cfrt767glv@pd.tnic>
 <35cc4ae0-e8fa-fd3a-5d7f-243ed2e82ea0@codeaurora.org>
 <20170421172603.4574wonnm5tgvbcn@pd.tnic>
Message-ID: <a20143dc-8daa-102b-d929-4d96f73353e3@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/21/2017 11:26 AM, Borislav Petkov wrote:
> On Fri, Apr 21, 2017 at 10:04:35AM -0600, Baicar, Tyler wrote:
>> This is basically what I already had in v14...you asked to move it into a
>> different if-statement? https://lkml.org/lkml/2017/4/12/397
> Well, clearly I've been smoking some nasty potent sh*t. :-\
>
> /me goes and looks at the spec:
>
> "Bit 0 ? Timestamp is precise if this bit is set and correlates to the
> time of the error event."
>
> So why are we even printing the timestamp when !precise?
>
> IOW, I think we should do:
>
> 	if (!(timestamp[3] & 0x1))
> 		printk("%stimestamp imprecise\n", pfx);
> 	else {
> 		sec = ..
> 		min = ...
>
> 		...
> 	}
>
> and print the actual values only when the timestamp is precise.
> Otherwise it has *some* values which could just as well be completely
> random. And it's not like we're reporting the error tomorrow - it is
> mostly a couple of seconds from logging to the fw pushing it out...
The timestamp may still be useful when it is imprecise. In the polling 
case, you may only poll every minute or so, so the time may be useful. 
Also, I imagine there could be interrupt based errors happening much 
faster than the FW/OS handshake can happen. Maybe we can just use what I 
had before but also specify imprecise so that it is clear:

         printk("%s%ststamp: %02d%02d-%02d-%02d %02d:%02d:%02d\n", pfx,
             (timestamp[3] & 0x1 ? "precise " : "imprecise "),
              century, year, mon, day, hour, min, sec);

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
