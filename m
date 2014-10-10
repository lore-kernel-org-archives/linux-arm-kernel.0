From: pjones@redhat.com (Peter Jones)
Date: Fri, 10 Oct 2014 09:53:45 -0400
Subject: [PATCH v3] arm64/efi: efistub: jump to 'stext' directly, not
 through the header
In-Reply-To: <CAFECyb9Tz2Fo2ix0VYiM7WPeie7C=woiVwyQtR4aH_HPcLwkOg@mail.gmail.com>
References: <1412777487-13636-1-git-send-email-ard.biesheuvel@linaro.org>
 <20141009172354.GA466@leverpostej>
 <CAKv+Gu-D812Rn32rm5wQJfSM+NzPXZWbxDcDkZ8mBzbi5RQJXQ@mail.gmail.com>
 <1412893179.29182.71.camel@deneb.redhat.com>
 <CAFECyb9Tz2Fo2ix0VYiM7WPeie7C=woiVwyQtR4aH_HPcLwkOg@mail.gmail.com>
Message-ID: <20141010135344.GB14660@fenchurch.internal.datastacks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 04:20:19PM -0700, Roy Franz wrote:
> I think we'll also run into some alignment issues if the loader really just
> loads the section ( we just have the one) rather than the whole file.
> From reviewing the PE/COFF spec again we violate the relationship
> between FileAlignment and SectionAlignment.

It's hard to pin down exactly whose burden this is - clearly the RVAs
and the File Addresses in the binary are supposed to jive with
SectionAlignment and FileAlignment, respectively, but if they don't,
it's unclear what a loader should do about it.  I've got some (x86)
hardware where LoadImage() rejects the binary entirely in this case, but
the code in tiano doesn't seem to care.  Our loader code in shim ignores
both fields entirely - once we've checked validity in terms of overlap
and boundaries, we happily give sections whatever offset they've
requested.  I suppose on some machines that may mean that a malformed
binary gets a /fault/ pretty quickly.  I'll add checks for those
alignments in shim 0.9 , release date TBD.

So because of that x86 machine that does error out, I've got some
different values here:
https://github.com/vathpela/shim/blob/manual-headers/crt0-efi-x86_64.S#L72
than Ard does in his Aarch64 headers.  There are some other things
wrong on that branch because I didn't understand well enough while
writing some of it - it's basically still there for reference, I don't
anticipate ever shipping it.

-- 
        Peter
