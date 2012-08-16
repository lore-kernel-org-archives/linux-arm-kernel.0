From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Aug 2012 11:28:09 +0100
Subject: [PATCH v2 21/31] arm64: 32-bit (compat) applications support
In-Reply-To: <201208151434.05145.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-22-git-send-email-catalin.marinas@arm.com>
 <201208151434.05145.arnd@arndb.de>
Message-ID: <20120816102808.GH31784@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 03:34:04PM +0100, Arnd Bergmann wrote:
> On Tuesday 14 August 2012, Catalin Marinas wrote:
> > +asmlinkage int compat_sys_personality(compat_ulong_t personality)
> > +{
> > +	int ret;
> > +
> > +	if (personality(current->personality) == PER_LINUX32 &&
> > +		personality == PER_LINUX)
> > +		personality = PER_LINUX32;
> > +	ret = sys_personality(personality);
> > +	if (ret == PER_LINUX32)
> > +		ret = PER_LINUX;
> > +	return ret;
> > +}
> 
> Where did you get this from?
> 
> You should not need compat_sys_personality, just call the native function.

Hmm, but in that case an aarch32 application doing a personality(PER_LINUX)
syscall will start seeing the wrong uname.

Will
