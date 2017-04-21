From: bp@alien8.de (Borislav Petkov)
Date: Fri, 21 Apr 2017 19:26:03 +0200
Subject: [PATCH V15 03/11] cper: add timestamp print to CPER status
 printing
In-Reply-To: <35cc4ae0-e8fa-fd3a-5d7f-243ed2e82ea0@codeaurora.org>
References: <1492556723-9189-1-git-send-email-tbaicar@codeaurora.org>
 <1492556723-9189-4-git-send-email-tbaicar@codeaurora.org>
 <20170421122150.76cce2cfrt767glv@pd.tnic>
 <35cc4ae0-e8fa-fd3a-5d7f-243ed2e82ea0@codeaurora.org>
Message-ID: <20170421172603.4574wonnm5tgvbcn@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 10:04:35AM -0600, Baicar, Tyler wrote:
> This is basically what I already had in v14...you asked to move it into a
> different if-statement? https://lkml.org/lkml/2017/4/12/397

Well, clearly I've been smoking some nasty potent sh*t. :-\

/me goes and looks at the spec:

"Bit 0 ? Timestamp is precise if this bit is set and correlates to the
time of the error event."

So why are we even printing the timestamp when !precise?

IOW, I think we should do:

	if (!(timestamp[3] & 0x1))
		printk("%stimestamp imprecise\n", pfx);
	else {
		sec = ..
		min = ...

		...
	}

and print the actual values only when the timestamp is precise.
Otherwise it has *some* values which could just as well be completely
random. And it's not like we're reporting the error tomorrow - it is
mostly a couple of seconds from logging to the fw pushing it out...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
