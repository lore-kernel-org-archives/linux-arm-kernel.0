From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 28 Jan 2014 12:54:42 -0800
Subject: [PATCH v3 1/2] init/do_mounts.c: ignore final \n in name_to_dev_t
In-Reply-To: <20140128185926.5312.36635@capellas-linux>
References: <1380834638-24035-1-git-send-email-sebastian.capella@linaro.org>
 <1380834638-24035-2-git-send-email-sebastian.capella@linaro.org>
 <20131003141523.8b60ab988799af7e2b2c338b@linux-foundation.org>
 <20131003214246.24540.99218@capellas-linux>
 <20131003234735.19051.84583@capellas-linux>
 <20131010175010.17870.58060@capellas-linux>
 <20131022175414.14753.58063@capellas-linux>
 <20140128185926.5312.36635@capellas-linux>
Message-ID: <20140128125442.4bac748945b404179deb58ba@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jan 2014 10:59:26 -0800 Sebastian Capella <sebastian.capella@linaro.org> wrote:

> > Do you have any feedback for me on this?
> > 
> > I'm happy do make any changes you think are correct, but I'm unsure if
> > you're asking me for option #3 above.  It's quite an intrusive change,
> > and changes old, established code and I'd like confirmation that's what
> > you'd like before proceeding down that path.
> > 
> > I've submitted patches with both options #1 and #2 above.
> > 
> > Thanks,
> > 
> > Sebastian
> 
> Ping.
> 
> Sorry for the lapse in attention to this.
> 
> Could you please clarify what is needed for this to be acceptable?
> I'm a little confused about what is being asked of me.

The problem is that kernel/power/hibernate.c:resume_store() is handed a
newline-terminated string, yes?  And if it blindly hands that string
over to name_to_dev_t(), name_to_dev_t() fails because the string is
wrong.

This is an oddity of the sysfs->kernel interface and altering
name_to_dev_t doesn't really seem appropriate for this problem - it
would be better to fix the caller to pass in the correct string.

Something like...

/*
 * Clean up a string which may have leading and/or trailing whitespace (as
 * defined by isspace()) by trimming off that whitespace.  Returns an address
 * which the caller must kfree(), or NULL on error.
 */
char *strim_copy(const char *s, gfp_t gfp)
{
	char *ret = kstrdup(skip_spaces(s), gfp);

	if (ret)
		strim(ret);
	return ret;
}
EXPORT_SYMBOL(strim_copy);
