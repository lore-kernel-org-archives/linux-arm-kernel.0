From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 29 Jan 2015 16:07:42 -0800
Subject: [PATCH 2/9] regulator: core: Introduce set_optimum_mode op
In-Reply-To: <20150128195204.GN21293@sirena.org.uk>
References: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1422413199-17273-3-git-send-email-bjorn.andersson@sonymobile.com>
 <20150128195204.GN21293@sirena.org.uk>
Message-ID: <20150130000741.GP11960@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 28 Jan 11:52 PST 2015, Mark Brown wrote:

> On Tue, Jan 27, 2015 at 06:46:32PM -0800, Bjorn Andersson wrote:
> 
> > +	/* set most efficient regulator operating mode for load */
> > +	int (*set_optimum_mode)(struct regulator_dev *, int input_uV,
> > +				int output_uV, int load_uA);
> 
> This is basically fine but can you please rename this to be something
> that more directly reflects the fact that we're just informing the
> driver about the operating parameters - there are other things a driver
> could usefully do with this, for example set current limits so that if
> something starts to consume excessive current the device will flag this
> as an error.
> 

The purpose of the series was to be able to implement patch 9, which
will utilize the load_uA to set the "mode" of the Qualcomm regulators.

So I would like it to be a "setter of current consumption".

I'm not sure what to name the function to have it cover these additional
cases.

> It'd also be better to split the voltage specs out into a separate
> function, especially for the output voltage where obviously we have a
> separate range based interface for setting that.

I was fishing for a statement regarding this in the cover letter, but
here we go.

The current implementors of get_optimum_mode all ignore the voltages, so
we could effectively simplify the interface to:

 get_optimum_mode(rdev, load);

Question is if there are any implementations where we don't know the
output voltage in the regulator driver (as locking prevents us from
using the standard interface of querying this). Input voltage is just a
query away.


Having drms_uA_update() request an appropriate mode for the given load
and then calling set_mode directly (the current implementation) gives us
a single point of entry to the regulator drivers related to setting
modes (regulator_set_mode and drms_uA_update calls set_mode). But seen
from a consumer there's no consistency; the last call to
regulator_set_mode() and regulator_set_optimum_mode() will win.

Further more, get_optimum_mode is not exposed to the consumers and there
are no other users in the regulator framework. So it could be completely
internal to the regulator drivers, without loss of functionality.


Looking at the consumers, in my mind they should not be aware of the
operating performance characteristics of the regulator supplying them.
So I think they should all use regulator_set_optimum_mode() rather than
"guessing" what performance mode the regulator should run in. (Maybe
some board code could use set_mode?).

With this in mind I was going to follow up after this series with a
rename of regulator_set_optimum_mode() to regulator_set_current() and
set_optimum_mode() to set_current().

I was also going to suggest dropping regulator_set_mode() and set_mode
to make the consumer facing API consistent.


I think this covers your concern about patch 3-7 as well, please let me
know what you think.

Regards,
Bjorn
