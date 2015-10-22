From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 22 Oct 2015 17:09:59 +0200
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
In-Reply-To: <57854232.vMTrn4EgZx@wuerfel>
References: <11282238.AHmyWliPRj@wuerfel>
 <20151013203812.GM17308@twins.programming.kicks-ass.net>
 <11817958.z9KtmeKzV7@wuerfel> <57854232.vMTrn4EgZx@wuerfel>
Message-ID: <20151022150959.GU17308@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 05:02:45PM +0200, Arnd Bergmann wrote:
> On Tuesday 13 October 2015 23:46:35 Arnd Bergmann wrote:
> > On Tuesday 13 October 2015 22:38:12 Peter Zijlstra wrote:
> > > A quick grep shows a large amount of trivial code that optimizers will
> > > still happily throw away, but it should be verified that this does not
> > > result in pointless code generation.
> > 
> > Indeed, I'm seeing a tiny code growth with ARM multi_v7_defconfig when
> > my patch is applied, as the image (according to size -A) grows from
> > 13740187 bytes to 13740283, all of it in .text of two drivers (i2c-core
> > and three files of bluetooth.ko).
> 
> 
> Did we actually reach any conclusion here? We still get the warnings
> in the regulator code in linux-next, and I'd like to see either this
> patch ("mutex: make mutex_lock_nested an inline function") or
> "regulator: core: avoid unused variable warning" get merged.
> 
> We could also remove the two functions again, as they are still
> unused and we are getting closer to the merge window.

Hmm, I was sure I send a reply, but I cannot even find it in my own sent
folder so who knows.

My current preference is to keep the thing a macro and work around it in
the usage site because while these warns are annoying, they're at least
visible. Whereas, with an inline, code bloat is entirely silent. Even if
the sites you found are harmless, there's no saying what the future will
bring etc..
