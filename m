From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Sep 2013 17:56:56 +0200
Subject: [PATCH 1/5] clk: mvebu: Add core-divider clock
In-Reply-To: <20130926151240.GB4583@localhost>
References: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130925213730.GA19371@localhost> <20130926082404.GA18244@lunn.ch>
 <20130926151240.GB4583@localhost>
Message-ID: <20130926155656.GF18244@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +	/* Valid ratio are 1:4, 1:5, 1:6 and 1:8 */
> > > +	u32 div;
> > > +
> > > +	div = *parent_rate / rate;
> > > +	if (div <= 4)
> > > +	   div = 4;
> > > +	   else if (div <= 5)
> > > +	   	div = 5;
> > > +		else if (div <= 6)
> > > +		     div = 6;
> > > +		     else
> > > +			div = 8;
> > > +
> > > +	return *parent_rate / div;
> > > +}
> > 
> > This looks odd. Is not the following clearer?
> > 
> > 	div = *parent_rate / rate;
> > 	if (div < 5)
> > 	   div = 4;
> > 	   else if (div > 6)
> > 		div = 8;
> > 
> 
> Mmmm... no, it's not at all clearer to me.
> IMHO, the original construction explicitly show the possible ratios:
> 
> 	/* If it's smaller than or equal to 4, set to 4 */
> 	if (div <= 4)
> 		div = 4;
> 
> 	/* Otherwise, if it's between 4 and 5, set to 5 */
> 	else if (div <= 5)
> 	 	div = 5;

If div was a float or double, i would probably agree. But its a u32.
It cannot be between 4 and 5. It must be 5. So it becomes

 	if (div <= 4)
 		div = 4;
        else if (div == 5)
	        div = 5;
        else if (div == 6)
                div = 6
        else 
	    div = 8

Those two middle statements look odd to me...

      Andrew
