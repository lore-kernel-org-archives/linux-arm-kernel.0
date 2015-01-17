From: jcm@redhat.com (Jon Masters)
Date: Sat, 17 Jan 2015 17:52:59 -0500
Subject: SMBIOS/DMI data under CONFIG_STRICT_DEVMEM
In-Reply-To: <CAOesGMi3=QkiQ326nFfGTjsOKrGqgO-q+r+A4Uc_9YWCDrAtwA@mail.gmail.com>
References: <54BAC21D.9040009@redhat.com>
 <CAOesGMi3=QkiQ326nFfGTjsOKrGqgO-q+r+A4Uc_9YWCDrAtwA@mail.gmail.com>
Message-ID: <54BAE7CB.2010705@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 01/17/2015 04:10 PM, Olof Johansson wrote:
> Hi,
> 
> On Sat, Jan 17, 2015 at 12:12 PM, Jon Masters <jcm@redhat.com> wrote:
>> Hi Catalin, all,
>>
>> I would like to ensure that the SMBIOS data provided by firmware is
>> always readable from userspace on AArch64, through /dev/mem.
> 
> Seems like this would be a good opportunity for cleanup and fixing
> userspace to use /sys/firmware/dmi interfaces instead of having to go
> poking through /dev/mem. That way they don't have to be privileged
> process any more and is a general security benefit for everybody.

I don't disagree :)

Indeed, I was pushing within RH years ago to help get it into
/sys/firmware/dmi where it lives today. Someone went over this code for
us a few months ago and the determination was that there's a chunk of
refactoring that needs doing to get it to do the right thing. I think in
the interim some of the vendor kernels might need another solution, but
I've already asked that Linaro refactor the tool to do it right.

There's probably good reasons to be able to poke at the tables directly
from userspace under certain circumstances too. For example, one of the
reference platforms I am using has bogus checksums in the tables so they
fail to load in the Linux interpreter which means you never see the
entries in /sys/firmware/dmi being created and could not debug why if
you had no direct access to read the raw ones. That means that probably
people would still carry hacks to allow such access.

Jon.
