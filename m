From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 24 May 2018 11:52:06 +0100
Subject: [PATCH 02/14] arm64: Call ARCH_WORKAROUND_2 on transitions
 between EL0 and EL1
In-Reply-To: <0b03ce12-510e-464b-63de-cd481d7cb1c5@arm.com>
References: <20180522150648.28297-1-marc.zyngier@arm.com>
 <20180522150648.28297-3-marc.zyngier@arm.com>
 <0b03ce12-510e-464b-63de-cd481d7cb1c5@arm.com>
Message-ID: <20180524105205.rq25srimaceo3ov4@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 10:23:20AM +0100, Julien Grall wrote:
> Hi Marc,
> 
> On 05/22/2018 04:06 PM, Marc Zyngier wrote:
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index ec2ee720e33e..f33e6aed3037 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -18,6 +18,7 @@
> >    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> >    */
> > +#include <linux/arm-smccc.h>
> >   #include <linux/init.h>
> >   #include <linux/linkage.h>
> > @@ -137,6 +138,18 @@ alternative_else_nop_endif
> >   	add	\dst, \dst, #(\sym - .entry.tramp.text)
> >   	.endm
> > +	// This macro corrupts x0-x3. It is the caller's duty
> > +	// to save/restore them if required.
> 
> NIT: Shouldn't you use /* ... */ for multi-line comments?

There's no requirement to do so, and IIRC even Torvalds prefers '//'
comments for multi-line things these days.

Mark.
