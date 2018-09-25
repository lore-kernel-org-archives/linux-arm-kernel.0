From: bp@alien8.de (Borislav Petkov)
Date: Tue, 25 Sep 2018 14:45:26 +0200
Subject: [PATCH v6 00/18] APEI in_nmi() rework
In-Reply-To: <20180921221705.6478-1-james.morse@arm.com>
References: <20180921221705.6478-1-james.morse@arm.com>
Message-ID: <20180925124526.GD23986@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 11:16:47PM +0100, James Morse wrote:
> Hello,
> 
> The GHES driver has collected quite a few bugs:
> 
> ghes_proc() at ghes_probe() time can be interrupted by an NMI that
> will clobber the ghes->estatus fields, flags, and the buffer_paddr.
> 
> ghes_copy_tofrom_phys() uses in_nmi() to decide which path to take. arm64's
> SEA taking both paths, depending on what it interrupted.
> 
> There is no guarantee that queued memory_failure() errors will be processed
> before this CPU returns to user-space.
> 
> x86 can't TLBI from interrupt-masked code which this driver does all the
> time.
> 
> 
> This series aims to fix the first three, with an eye to fixing the
> last one with a follow-up series.
> 
> Previous postings included the SDEI notification calls, which I haven't
> finished re-testing. This series is big enough as it is.

Yeah, and everywhere I look, this thing looks overengineered. Like,
for example, what's the purpose of this ghes_esource_prealloc_size()
computing a size each time the pool changes size?

AFAICT, this size can be computed exactly *once* at driver init and be
done with it. Right?

Or am I missing something subtle?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
