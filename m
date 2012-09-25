From: mmayer@broadcom.com (Markus Mayer)
Date: Tue, 25 Sep 2012 16:51:47 -0700
Subject: [PATCH 1/1] Fix segfault in DTC
In-Reply-To: <20120925233054.GL9800@truffula.fritz.box>
References: <1348526885-2113-1-git-send-email-mmayer@broadcom.com>
 <1348595889-6495-1-git-send-email-mmayer@broadcom.com>
 <1348595889-6495-2-git-send-email-mmayer@broadcom.com>
 <20120925233054.GL9800@truffula.fritz.box>
Message-ID: <50624393.30607@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/2012 16:30, David Gibson wrote:
> On Tue, Sep 25, 2012 at 10:58:09AM -0700, Markus Mayer wrote:
>> Prior to this change, an empty input file would cause a segfault, because
>> yylloc had never been initialized. There was never any characters for the
>> lexer to match, so YY_USER_ACTION was never executed before the parse error
>> was detected.
>>
>> When the parser printed the error message, it tried to include the name of
>> the file, but the structure holding the file name (yylloc.file, referenced
>> as pos->file) had never been initialized.
>>
>> Without the fix:
>>
>> $ ./dtc /dev/null
>> DTC: dts->dts  on file "/dev/null"
>> Segmentation fault (core dumped)
>>
>> $ gdb dtc core
>> Program terminated with signal 11, Segmentation fault.
>>      at scripts/dtc/srcpos.c:194
>> 194			fname = pos->file->name;
>> (gdb) bt
>>      at scripts/dtc/srcpos.c:194
>>      fmt=0x40d769 "%s", va=0x7fffbf027148) at scripts/dtc/srcpos.c:220
>>      at scripts/dtc/dtc-parser.tab.c:1920
>>      at scripts/dtc/treesource.c:38
>>      at scripts/dtc/dtc.c:203
>> (gdb) p *pos
>> $1 = {first_line = 0, first_column = 0, last_line = 0, last_column = 0,
>>    file = 0x0}
>
> Which dtc version did you observe this with?  I'm unable to reproduce
> the SEGV with current git.

That was

$ cat version_gen.h
#define DTC_VERSION "DTC 1.2.0-g37c0b6a0"

from git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git. 
In other words, the DTC used by the Linux 3.6-rc series.

Regards,
-Markus
