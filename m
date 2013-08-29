From: james.hogan@imgtec.com (James Hogan)
Date: Thu, 29 Aug 2013 12:02:34 +0100
Subject: clk: move some parent related functions upwards
In-Reply-To: <20130829104847.GA27486@elgon.mountain>
References: <20130829104847.GA27486@elgon.mountain>
Message-ID: <521F2A4A.5040208@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

On 29/08/13 11:48, Dan Carpenter wrote:
> Hello James Hogan,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 4935b22c46ea: "clk: move some parent related functions 
> upwards" from Jul 29, 2013, leads to the following Smatch complaint:
> 
> drivers/clk/clk.c:1160 __clk_set_parent()
> 	 warn: variable dereferenced before check 'parent' (see line 1156)
> 
> drivers/clk/clk.c
>   1155		flags = clk_enable_lock();
>   1156		clk_reparent(clk, parent);
>                                   ^^^^^^
> Patch addes dereference.
> 
>   1157		clk_enable_unlock(flags);
>   1158	
>   1159		/* change clock input source */
>   1160		if (parent && clk->ops->set_parent)
>                     ^^^^^^
> Patch adds a check.
> 
>   1161			ret = clk->ops->set_parent(clk->hw, p_index);
>   1162	
> 
> Also the caller has similar issues.  Could you CC me if you send a fix?
> 
> regards,
> dan carpenter
> 

This one is the same problem as the "clk: add support for clock reparent
on set_rate" one that you reported yesterday (for which I am about to
send a fix - I'll Cc you). This particular patch merely moves some
related code without changing anything.

Cheers
James
