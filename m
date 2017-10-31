From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Oct 2017 10:36:16 +0000
Subject: [PATCH v3 05/12] arm: vdso: do calculations outside reader loops
In-Reply-To: <040cf1cc-28a0-0f4c-1c08-7bc8a9dc75a2@android.com>
References: <20171027222543.57279-1-salyzyn@android.com>
 <20171030141517.25ex2os47cyvah2z@lakrids.cambridge.arm.com>
 <040cf1cc-28a0-0f4c-1c08-7bc8a9dc75a2@android.com>
Message-ID: <20171031103615.urjintbmv4i5cw4a@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 01:27:22PM -0700, Mark Salyzyn wrote:
> Thanks for the review, am taking all the points into consideration.
> 
> On 10/30/2017 07:15 AM, Mark Rutland wrote:
> > > +
> > > +	typeof(((struct vdso_data *)vd)->xtime_clock_sec) sec;
> > Why do we need to do this typeof() magic?
> > 
> > Can't we settle on a consistent type across arches, or have a typedef in
> > a header?
> 
> Would you accept 'because I do not want to standardize the sizes yet'?

Well, a typedef would solve that issue. e.g. each arch can have:

  typedef u64 vdso_xtime_sec_t;

... or

  typedef u32 vdso_xtime_sec_t;

... in headers for native/compat, and the above can be:

  vdso_xtime_sec_t sec

... with the same type in the relevant struct.

That way the type can differ per arch. If we want to do something more
complicated later, we can always rework the code.

Thanks,
Mark.
