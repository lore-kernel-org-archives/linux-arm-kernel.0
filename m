From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Jan 2012 14:11:28 +0000
Subject: Clock API and "maximum rate"
In-Reply-To: <CAKGA1bnZLDXEBAL4MPa48vKEkjn6t-0Umekgy2Y9c8p0Y8CLyQ@mail.gmail.com>
References: <CAKGA1bmZGxxSfwGkpdyt7c-UYUTj+mV2AZhmhCUSEKTd12Q+4Q@mail.gmail.com>
 <20120111165844.GL3226@page>
 <CAKGA1bnZLDXEBAL4MPa48vKEkjn6t-0Umekgy2Y9c8p0Y8CLyQ@mail.gmail.com>
Message-ID: <20120112141128.GK1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 07:49:35AM -0600, Matt Sealey wrote:
> On Wed, Jan 11, 2012 at 10:58 AM, Jamie Iles <jamie@jamieiles.com> wrote:
> > Hi Matt,
> >
> > On Wed, Jan 11, 2012 at 10:30:15AM -0600, Matt Sealey wrote:
> >> Just a curious question, is there any safe way in the current API or
> >> even by peeking a little behind the scenes to find out what the
> >> maximum clock rate would be for a given named clock or struct clk?
> >
> > How about:
> >
> > ? ? ? ?long max = clk_round_rate(clk, ~0LU);
> >
> > clk_round_rate() is one of the optional API calls though.
> 
> Luckily implemented in this case :) Seems to do the trick, thanks.

If it's not implemented, but there is an implemented clk_set_rate(), feel
free to complain at whoever created the implementation.

If there's a clk_set_rate() implementation, then there's _already_ an
implementation of clk_round_rate() internally doing the rounding for the
set_rate function, so there's really no excuse not to expose that via
clk_round_rate().

clk_round_rate() is supposed to tell you what you end up with if you
ask clk_set_rate() to set the exact same value you passed in - but
clk_round_rate() won't modify the hardware.

So, clk_round_rate/clk_set_rate really should be thought of being
implemented as this:

long clk_round_rate(struct clk *clk, unsigned long rate)
{
	return __clk_round_rate(clk, rate);
}

int clk_set_rate(struct clk *clk, unsigned long rate)
{
	long rate = __clk_round_rate(clk, rate);

	if (rate < 0)
		return rate;

	return __clk_set_rate(clk, rate);
}
