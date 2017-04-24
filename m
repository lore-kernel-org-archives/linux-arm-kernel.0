From: bp@alien8.de (Borislav Petkov)
Date: Mon, 24 Apr 2017 19:52:40 +0200
Subject: [PATCH V15 04/11] efi: parse ARM processor error
In-Reply-To: <e54c9893-446f-9e77-b78b-2548d394719b@codeaurora.org>
References: <1492556723-9189-1-git-send-email-tbaicar@codeaurora.org>
 <1492556723-9189-5-git-send-email-tbaicar@codeaurora.org>
 <20170421175527.fjwnqd22jz7br5yu@pd.tnic>
 <e54c9893-446f-9e77-b78b-2548d394719b@codeaurora.org>
Message-ID: <20170424175240.3nvhbxzwicxnk6og@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 12:22:09PM -0600, Baicar, Tyler wrote:
> I guess it's not really needed. It just may be useful considering there can
> be numerous error info structures, numerous context info structures, and a
> variable length vendor information section. I can move this print to only in
> the length check failure cases.

And? Why does the user care?

I mean, it is good for debugging when you wanna see you're parsing the
error info data properly but otherwise it doesn't improve the error
reporting one bit.

> Because these are part of the error information structure. I wouldn't think
> FW would populate error information structures that are different versions
> in the same processor error, but it could be possible from the spec (at
> least once there are different versions of the table).

Same argument as above.

> There is an error information 64 bit value in the ARM processor error
> information structure. (UEFI spec 2.6 table 261)

So that's IP-dependent and explained in the following tables. Any plans
on decoding that too?

> Why's that? Dumping this vendor specific error information is similar to the
> unrecognized CPER section reporting which is also meant for vendor specific
> information https://lkml.org/lkml/2017/4/18/751

And how do those naked bytes help the user understand the error happening?

Even in your example you have:

[  140.739210] {1}[Hardware Error]:   00000000: 4d415201 4d492031 453a4d45 435f4343  .RAM1 IMEM:ECC_C
[  140.739214] {1}[Hardware Error]:   00000010: 53515f45 44525f42 00000000 00000000  E_QSB_RD........

Which looks like some correctable ECC DRAM error and is actually begging
to be decoded in a human-readable form. So let's do that completely and
not dump partially decoded information.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
